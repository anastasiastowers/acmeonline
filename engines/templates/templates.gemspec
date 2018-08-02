$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "templates/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "templates"
  s.version     = Templates::VERSION
  s.authors     = ["Anastasia Stowers"]
  s.email       = ["anastasia.k.stowers@gmail.com"]
  s.summary     = "Shared UI Styles and Components"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency 'haml-rails'
  s.add_dependency 'bootstrap', '~> 4.1.3'
  s.add_dependency 'jquery-rails'

  s.add_development_dependency "sqlite3"
end