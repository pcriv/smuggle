# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smuggle/version"

Gem::Specification.new do |spec|
  spec.name          = "smuggle"
  spec.email         = ["pablocrivella@gmail.com", "info@inspire.nl"]
  spec.version       = Smuggle::VERSION
  spec.authors       = ["Pablo Crivella", "InspireNL"]
  spec.homepage      = "https://github.com/InspireNL/smuggle"
  spec.license       = "MIT"
  spec.summary       = "It exports and imports all kinds of stuff from and to CSV"
  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/InspireNL/smuggle/issues",
    "changelog_uri"   => "https://github.com/InspireNL/smuggle/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/InspireNL/smuggle"
  }
  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "faker", "~> 1.8"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "rubocop", "~> 0.59"
  spec.add_development_dependency "rubocop-rspec", "~> 1.29"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
