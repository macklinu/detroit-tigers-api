# frozen_string_literal: true

describe 'Detroit Tigers API' do
  describe 'GET /' do
    it 'should return Hello World!' do
      get '/'

      expect_status(200)
      expect(body).to eql 'Hello World!'
    end
  end
  describe 'GET /games/all' do
    it 'returns all games in the database' do
      num_games = 3
      create_list(:game, num_games)

      get '/games/all'

      expect_status(200)
      expect_json_sizes(num_games)
      expect_json_types('*', id: :int,
                             opponent: :string,
                             date: :date,
                             time: :date)
    end
  end
  describe 'GET /games/upcoming' do
    it 'returns the next 7 days of games by default' do
      now = Date.today
      six_days_from_now = now + 6.days
      (now..six_days_from_now).each do |date|
        create(:game, date: date)
      end

      get '/games/upcoming'

      expect_status(200)
      expect_json_sizes(7)
      expect_json_types('*', id: :int,
                             opponent: :string,
                             date: :date,
                             time: :date)
      expect_json('0', date: now.strftime('%F'))
      expect_json('6', date: six_days_from_now.strftime('%F'))
    end
  end
  describe 'Error handling' do
    describe '404' do
      it 'returns proper error message' do
        get '/invalid_endpoint'

        expect_status(404)
        expect_json(message: 'Not found')
      end
    end
  end
end
