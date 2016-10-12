require 'pronto'
require 'shellwords'

module Pronto
  class Phpcs < Runner
    def run
      return [] if !@patches

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
      escaped_path = Shellwords.escape(path)
      JSON.parse(`phpcs #{escaped_path} --report=json`)
        .fetch('files', {})
        .fetch(path, {})
        .fetch('messages', [])
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