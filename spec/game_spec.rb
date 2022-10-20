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
        allow(game_play).to receive(:introduction)
        allow(game_play).to receive(:turn)
        allow(game_play).to receive(:game_over?).and_return(true)
        allow(game_play.board).to receive(:win?).and_return(true)
        allow(game_play).to receive(:play_again?).and_return(false)
      end
      it 'ends the loop and displays victory message' do
        victory_message = 'Congratulations to player ⚪, you won the game!!'
        expect(game_play).to receive(:puts).with(victory_message)
        game_play.play
      end
    end

    context 'when game is not won once and then won' do
      before do
        allow(game_play).to receive(:game_over?).and_return(false, true)
        allow(game_play).to receive(:play_again?).and_return(false)
      end
      it 'loops twice' do
        expect(game_play).to receive(:turn).twice
        game_play.play
      end
    end
  end

  describe '#end_message' do
    subject(:game_message) { described_class.new }

    context 'when game is won' do
      it 'returns victory message' do
        piece = '⚪'
        victory_message = 'Congratulations to player ⚪, you won the game!!'
        allow(game_message.board).to receive(:win?).and_return(true)
        expect(game_message.end_message(piece)).to eq(victory_message)
      end
    end

    context 'when game is drawn' do
      it 'returns draw message' do
        piece = '⚫'
        draw_message = 'The game is drawn, good play by both players!'
        allow(game_message.board).to receive(:draw?).and_return(true)
        expect(game_message.end_message(piece)).to eq(draw_message)
      end
    end
  end

  describe '#game_end' do
    subject(:game_ending) { described_class.new }
    let(:winning_player) { instance_double('Player', piece: '⚪') }
    context 'when winning player is ⚪' do
      before do
        allow(game_ending.board).to receive(:win?).and_return(true)
        allow(game_ending).to receive(:play_again?).and_return(false)
      end

      it 'prints appropriate message' do
        victory_message = 'Congratulations to player ⚪, you won the game!!'
        expect(game_ending).to receive(:puts).with(victory_message)
        game_ending.game_end(winning_player)
      end
    end
    context 'when user wants to play again' do
      let(:new_game) { described_class.new }
      before do
        allow(game_ending).to receive(:end_message)
        allow(game_ending).to receive(:play_again?).and_return(true)
        allow(new_game).to receive(:play)
      end
      it 'sends message to Game to create new instance' do
        expect(Game).to receive(:new).and_return(new_game)
        game_ending.game_end(winning_player)
      end
    end
  end
end
