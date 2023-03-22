# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html_format/version'

Gem::Specification.new do |spec|
  spec.name         = 'html_format'
  spec.version      = HtmlFormat::VERSION
  spec.author       = 'akicho8'
  spec.email        = 'akicho8@gmail.com'
  spec.homepage     = 'https://github.com/akicho8/html_format'
  spec.summary      = 'A small library that easily converts various objects to HTML.'
  spec.description  = 'A small library that easily converts various objects to HTML.'
  spec.platform     = Gem::Platform::RUBY

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.rdoc_options  = ['--line-numbers', '--inline-source', '--charset=UTF-8', '--diagram', '--image-format=jpg']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'actionpack'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency "rails"
  spec.add_development_dependency "sass-rails"
  spec.add_development_dependency "sqlite3"
end
