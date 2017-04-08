# frozen_string_literal: true

# This migration removes the location column from the games table.
# To get an MVP up and running, I don't want to parse if a game is home or away.
class RemoveLocationFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :location, :integer, default: 0
  end
end
