# frozen_string_literal: true

require './game.rb'

describe Game do
  describe '.from_hash' do
    it 'creates a Game model from a past game (no time)' do
      game = Game.from_hash(
        date: 'Mon, 4/3',
        opponent: 'at White Sox',
        result: 'Postponed',
        record: '0-0',
        winning_pitcher: 'Verlander(0-0)',
        losing_pitcher: 'Quintana(0-0)'
      )
      game.save
      expect(game.time).to be_falsy
    end
    it 'creates a Game model from a future game with time' do
      game = Game.from_hash(
        date: 'Fri, 4/7',
        opponent: 'Red Sox',
        time: '1:10p',
        broadcast: 'MLBN, FS-D, MLB.TV',
        probable_pitcher: 'Fulmer (0-0)',
        opposing_pitcher: 'Wright (0-0)'
      )
      game.save
      expect(game.time).to be_truthy
    end
    it 'creates a Game model from a future game with TBD time' do
      game = Game.from_hash(
        date: 'Fri, 4/7',
        opponent: 'Red Sox',
        time: 'TBD',
        broadcast: 'MLBN, FS-D, MLB.TV',
        probable_pitcher: 'Fulmer (0-0)',
        opposing_pitcher: 'Wright (0-0)'
      )
      game.save
      expect(game.time).to be_falsy
    end
  end
end
