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

  describe '#play' do
    subject(:game_play) { described_class.new }

    before(:each) do
      allow(game_play).to receive(:pick_color).and_return('⚪')
      allow(game_play).to receive(:print_board)
    end

    context 'when game is won' do
      before do
        allow(game_play).to receive(:turn)
        allow(game_play).to receive(:game_over?).and_return(true)
      end
      it 'ends the loop and displays winning message' do
        winning_message = 'Congratulations to player ⚪, you won the game!!'
        expect(game_play).to receive(:puts).with(winning_message)
        game_play.play
      end
    end

    context 'when game is not won once and then won' do
      before do
        allow(game_play).to receive(:game_over?).and_return(false, true)
      end
      it 'loops twice' do
        expect(game_play).to receive(:turn).twice
        game_play.play
      end
    end
  end
end
