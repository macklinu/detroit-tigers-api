# frozen_string_literal: true

# rubocop:disable Style/Documentation
class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.date :date, null: false
      t.time :time, null: true
      t.string :opponent
      t.integer :location, default: 0

      t.timestamps
    end
  end
end
