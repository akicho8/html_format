$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "html_format/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "html_format"
  s.version     = HtmlFormat::VERSION
  s.authors     = ["akicho8"]
  s.email       = ["akicho8@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of HtmlFormat."
  s.description = "Description of HtmlFormat."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "sass-rails"

  s.add_development_dependency "sqlite3"
end
