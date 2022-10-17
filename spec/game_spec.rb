require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  describe '#create_players' do
    subject(:game_players) { described_class.new }

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

  describe '#pick_column' do
    subject(:game_pick) { described_class.new }
    context 'when picking an available column' do
      before do
        allow(game_pick).to receive(:gets).and_return('1')
      end
      it 'sends message to Player to make play' do
        current_player = instance_double('Player', piece: '⚫')
        board = instance_double('Board')
        column_number = 1
        expect(current_player).to receive(:make_play).with(board, column_number)
        game_pick.pick_column(current_player)
      end
    end
  end
end
