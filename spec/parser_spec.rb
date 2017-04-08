# frozen_string_literal: true

require './parser.rb'

describe TigersScheduleParser do
  def prepared_subject
    html = fixture('tigers-schedule-ajax.html')
    TigersScheduleParser.new(html)
  end
  subject { prepared_subject }

  describe '#data_hash' do
    it 'returns past data for id: "past"' do
      data = subject.data_hash id: 'past'
      expect(data.length).to eql 4
      expect(data.first).to eql(
        date: 'Mon, 4/3',
        opponent: 'at White Sox',
        result: 'Postponed',
        record: '0-0',
        winning_pitcher: 'Verlander(0-0)',
        losing_pitcher: 'Quintana(0-0)'
      )
    end
    it 'returns future data for id: "future"' do
      data = subject.data_hash id: 'future'
      expect(data.length).to eql 160
      expect(data.first).to eql(
        date: 'Fri, 4/7',
        opponent: 'Red Sox',
        time: '1:10p',
        broadcast: 'MLBN, FS-D, MLB.TV',
        probable_pitcher: 'Fulmer (0-0)',
        opposing_pitcher: 'Wright (0-0)'
      )
    end
  end
end
