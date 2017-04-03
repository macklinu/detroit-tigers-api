require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/reloader' if development?

before do
  content_type :json
end

get '/' do
  'Hello World!'
end

get '/games/all' do
  json Game.all
end

class Game < ActiveRecord::Base
  enum location: {
    home: 0,
    away: 1
  }
end
