# frozen_string_literal: true

require 'airborne'
require 'awesome_print'
require 'chronic'
require 'database_cleaner'
require 'factory_girl'
require 'faker'
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../api.rb', __FILE__
Dir['./spec/support/**/*.rb'].each { |file| require file }

FactoryGirl.definition_file_paths = %w[./spec/factories]
FactoryGirl.find_definitions

Airborne.configure do |config|
  config.rack_app = Sinatra::Application
end

module FixturesHelper
  def fixture(file_name)
    File.open("#{File.dirname(__FILE__)}/fixtures/#{file_name}").read
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include FixturesHelper

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
