# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?
require './game.rb'

before do
  content_type :json
end

namespace '/v1' do
  get '/games/upcoming' do
    json Game.where(date: Date.today..Date.today + 6.days)
  end
end

not_found do
  json message: 'Not found'
end
