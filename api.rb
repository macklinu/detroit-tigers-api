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

get '/games/upcoming' do
  json Game.where(date: Date.today..Date.today + 6.days)
end
