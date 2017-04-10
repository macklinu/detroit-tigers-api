# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?
require './game.rb'

namespace '/v1' do
  get '/games/upcoming' do
    content_type :json
    games = Game.where(date: Date.today..Date.today + 6.days)
    json games.map(&:to_json)
  end
end

not_found do
  json message: 'Not found'
end
