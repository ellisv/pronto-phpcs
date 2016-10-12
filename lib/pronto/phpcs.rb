require 'pronto'
require 'shellwords'
require 'json'

module Pronto
  class Phpcs < Runner
    def initialize(patches, commit = nil)
      super

      @executable = ENV['PRONTO_PHPCS_EXECUTABLE'] || 'phpcs'
      @standard = ENV['PRONTO_PHPCS_STANDARD'] || 'PSR2'
    end

    def run
      return [] unless @patches

      @patches.select { |patch| valid_patch?(patch) }
        .map { |patch| inspect(patch) }
        .flatten.compact
    end

    def valid_patch?(patch)
      patch.additions > 0 && php_file?(patch.new_file_full_path)
    end

    def inspect(patch)
      path = patch.new_file_full_path.to_s
      run_phpcs(path).map do |offence|
        patch.added_lines.select { |line| line.new_lineno == offence['line'] }
          .map { |line| new_message(offence, line) }
      end
    end

    def run_phpcs(path)
      escaped_executable = Shellwords.escape(@executable)
      escaped_standard = Shellwords.escape(@standard)
      escaped_path = Shellwords.escape(path)

      begin
        JSON.parse(`#{escaped_executable} --report=json --standard=#{escaped_standard} #{escaped_path}`)
          .fetch('files', {})
          .fetch(path, {})
          .fetch('messages', [])
      rescue JSON::ParserError
        []
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      level = if offence['type'] == 'ERROR' then :error else :warning end

      Message.new(path, line, level, offence['message'], nil, self.class)
    end

    def php_file?(path)
      File.extname(path) == '.php'
    end
  end
end
