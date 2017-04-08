# frozen_string_literal: true

require 'nokogiri'

# Parses the Detroit Tigers HTML schedule
class TigersScheduleParser
  def initialize(html)
    @page = Nokogiri::HTML(html)
  end

  def data_hash(id:)
    create_hash(
      headers: headers_for(id: id),
      data: data_for(id: id),
      ignore_keys: :tickets
    )
  end

  private

  def headers_for(id:)
    @page
      .css("##{id} thead tr td")
      .map { |row| row.text.gsub(/[[:space:]]/, '_').downcase.to_sym }
  end

  def data_for(id:)
    @page
      .xpath("//table[@id=\"#{id}\"]/tbody/tr[not(contains(@style, \"none\"))]")
      .map { |row| row.children.map(&:text) }
  end

  def create_hash(headers:, data:, ignore_keys:)
    data.map do |row|
      Hash[headers.zip(row)].tap do |h|
        [*ignore_keys].each { |key| h.delete(key) }
      end
    end
  end
end
