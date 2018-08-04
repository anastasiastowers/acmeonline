$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "payments/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payments"
  s.version     = Payments::VERSION
  s.authors     = ["Anastasia Stowers"]
  s.email       = ["anastasia.k.stowers@gmail.com"]
  s.summary     = "Payments Engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "templates"

  s.add_development_dependency "sqlite3"
end
