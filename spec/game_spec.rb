require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  describe '#create_players' do
    subject(:game_players) { described_class.new }
    let(:player1) { instance_double('Player', piece: '⚪') }
    let(:player2) { instance_double('Player', piece: '⚫') }

    it 'creates players' do
      player = class_double('Player').as_stubbed_const
      expect(player).to receive(:new).twice
      game_players.create_players
    end
  end
end
