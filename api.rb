require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?

get '/' do
  'Hello World!'
end
