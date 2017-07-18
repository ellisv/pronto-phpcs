# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/phpcs/version'

Gem::Specification.new do |spec|
  spec.name = 'pronto-phpcs'
  spec.version = Pronto::PhpcsVersion::VERSION
  spec.authors = ['Eligijus Vitkauskas']
  spec.email = ['eligijusvitkauskas@gmail.com']

  spec.summary = 'Pronto runner for PHP CodeSniffer'
  spec.homepage = 'https://github.com/EllisV/pronto-phpcs'
  spec.license = 'MIT'

  spec.files = Dir.glob('lib/**/*.rb') + ['pronto-phpcs.gemspec', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('pronto', ['~> 0.8.0', '< 0.10.x'])
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
