# frozen_string_literal: true

require 'timeliness'

# :nodoc:
class Game < ActiveRecord::Base
  def self.from_hash(hash)
    Game.new(
      opponent: hash.fetch(:opponent),
      date: parse_date(hash.fetch(:date)),
      time: parse_time(hash.fetch(:time, nil))
    )
  end

  def self.parse_date(date)
    _, month_day = date.split(',').map(&:strip)
    Timeliness.parse("#{month_day}/17") # Parse as 2017 date
  end

  def self.parse_time(time)
    Timeliness.parse("#{time}m") unless time.nil? || time == 'TBD'
  end

  def to_json
    {
      date: date,
      time: time,
      opponent: opponent
    }
  end

  private_class_method :parse_date
  private_class_method :parse_time
end
