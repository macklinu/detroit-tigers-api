# frozen_string_literal: true

describe 'Detroit Tigers API' do
  describe '/v1' do
    describe 'GET /games/upcoming' do
      it 'returns the next 7 days of games by default' do
        now = Date.today
        six_days_from_now = now + 6.days
        (now..six_days_from_now).each do |date|
          create(:game, date: date)
        end

        get '/v1/games/upcoming'

        expect_status(200)
        expect_json_sizes(7)
        expect_json_types('*', opponent: :string,
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
end
