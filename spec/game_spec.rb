require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  describe '#create_players' do
    subject(:game_players) { described_class.new }
    let(:player1) { instance_double('Player', piece: '⚪', type: 'human') }
    let(:player2) { instance_double('Player', piece: '⚫', type: 'computer') }

    it 'creates players' do
      player = class_double('Player').as_stubbed_const
      expect(player).to receive(:new).twice
      game_players.create_players('⚪')
    end
  end

  describe '#print_board' do
    subject(:game_print) { described_class.new }
    it 'prints the board on the screen' do
      board = ['   ➊  ➋  ➌  ➍  ➎  ➏  ➐',
               '  ┃  |  |  |  |  |  |  ┃',
               '  ┃  |  |  |  |  |  |  ┃',
               '  ┃  |  |  |  |  |  |  ┃',
               '  ┃  |  |  |  |  |  |  ┃',
               '  ┃  |  |  |  |  |  |  ┃',
               '  ┃  |  |  |  |  |  |  ┃',
               ' ╱╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲╲']

      board.each do |line|
        expect(game_print).to receive(:puts).with(line)
      end

      game_print.print_board
    end
  end
end
