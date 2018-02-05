require 'bundler/setup'
require 'smuggle'
require 'support/user'
require 'support/exporters/with_attributes'
require 'support/exporters/without_attributes'
require 'support/exporters/with_attributes_and_labels'
require 'support/importers/user_importer'
require 'factory_bot'
require 'faker'
require 'pry'
require 'pry-byebug'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
