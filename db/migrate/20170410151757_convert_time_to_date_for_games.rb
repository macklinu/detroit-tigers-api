# frozen_string_literal: true

# :nodoc:
class ConvertTimeToDateForGames < ActiveRecord::Migration[5.0]
  def up
    remove_column :games, :time
    add_column :games, :time, :datetime
  end

  def down
    remove_column :games, :time
    add_column :games, :time, :time
  end
end
