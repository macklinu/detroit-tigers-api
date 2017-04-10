# frozen_string_literal: true

require 'chronic'

# :nodoc:
class Game < ActiveRecord::Base
  def self.from_hash(hash)
    date = parse_date(hash.fetch(:date))
    Game.new(
      opponent: hash.fetch(:opponent),
      date: date,
      time: parse_time(date, hash.fetch(:time, nil))
    )
  end

  def self.parse_date(date)
    _, month_day = date.split(',').map(&:strip)
    Chronic.parse("#{month_day}/17") # Parse as 2017 date
  end

  def self.parse_time(date, time)
    return nil if time.nil? || time == 'TBD'
    Chronic.parse("#{date.strftime('%F')} #{time}m")
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
