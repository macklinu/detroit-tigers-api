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
end
