# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require './game.rb'

before do
  content_type :json
end

get '/' do
  'Hello World!'
end

get '/games/all' do
  json Game.all
end
