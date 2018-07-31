$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "storefront/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "storefront"
  s.version     = Storefront::VERSION
  s.authors     = ["Anastasia Stowers"]
  s.email       = ["anastasia.k.stowers@gmail.com"]
  s.summary     = "Storefront Engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
