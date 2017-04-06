# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :db do
  task :load_config do
    require './api'
  end
end
