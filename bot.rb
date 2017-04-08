# frozen_string_literal: true

require 'capybara/dsl'
require 'capybara/poltergeist'
require './game.rb'
require './parser.rb'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
end

# Scrapes Detroit Tigers schedule and creates game database records
class TigersScheduleBot
  include Capybara::DSL

  URL = 'http://detroit.tigers.mlb.com/schedule/sortable.jsp?c_id=det&year=2017'

  def scrape_and_save!
    visit URL
    parser = TigersScheduleParser.new(page.html)
    past_data = parser.data_hash(id: 'past')
    future_data = parser.data_hash(id: 'future')
    Game.delete_all
    games = [*past_data, *future_data].map { |hash| Game.from_hash(hash) }
    Game.transaction do
      games.each(&:save!)
    end
  end
end
