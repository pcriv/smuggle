# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smuggle/version"

Gem::Specification.new do |spec|
  spec.authors = ["Pablo Crivella", "InspireNL"]
  spec.email = ["pablocrivella@gmail.com", "info@inspire.nl"]
  spec.homepage = "https://github.com/InspireNL/smuggle"
  spec.license = "MIT"
  spec.name = "smuggle"
  spec.summary = "It exports and imports all kinds of stuff from and to CSV"
  spec.version = Smuggle::VERSION
  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/InspireNL/smuggle/issues",
    "changelog_uri" => "https://github.com/InspireNL/smuggle/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/InspireNL/smuggle",
  }
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "faker", "~> 2.1"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-rspec", "~> 1.3"
  spec.add_development_dependency "simplecov", "~> 0.1"
  spec.add_development_dependency "standard", "~> 0.5.2"
end
