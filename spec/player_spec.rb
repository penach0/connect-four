require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  subject(:player) { described_class.new('⚫', 'human') }

  describe '#initialize' do
    it 'has a color attribute' do
      expect(player).to have_attributes(piece: String)
    end

    context 'when passed ⚫ as an argument' do
      it 'sets ⚫ as piece' do
        expect(player.instance_variable_get('@piece')).to eq('⚫')
      end
    end

    context 'when passed ⚪ as an argument' do
      let(:player_white) { described_class.new('⚪', 'human') }
      it 'sets ⚪ as piece' do
        expect(player_white.instance_variable_get('@piece')).to eq('⚪')
      end
    end
  end

  describe '#make_play' do
    context 'when given a number' do
      subject(:board) { instance_double('Board') }

      it 'sends message to update the respective slot' do
        piece = player.piece
        column_number = 2
        expect(board).to receive(:update_slot).with(column_number, piece)
        player.make_play(board, column_number)
      end
    end
  end

  describe '#pick_column' do
    let(:pick_board) { instance_double('Board') }
    context 'when picking an available column' do
      before do
        allow(player).to receive(:gets).and_return('1')
        allow(pick_board).to receive(:valid_play?).and_return(true)
      end
      it 'returns the column number' do
        column_number = 1
        expect(player.pick_column(pick_board)).to eq(column_number)
      end
    end

    context 'when picking invalid column once' do
      before do
        initial_message = '⚫ playing. Pick a number: '
        allow(player).to receive(:print).with(initial_message)
        allow(pick_board).to receive(:valid_play?).and_return(false, true)
      end
      it 'runs the loop twice' do
        warning_message = 'Not valid, pick another one: '
        expect(player).to receive(:print).with(warning_message)
        player.pick_column(pick_board)
      end
    end
  end

  describe '#random_column' do
    let(:random_board) { instance_double('Board') }
    context 'when random number is valid' do
      before do
        allow(player).to receive(:rand).and_return(5)
        allow(random_board).to receive(:column_full?).and_return(false)
      end
      it 'returns the random number' do
        random_number = 5
        expect(player.random_column(random_board)).to eq(random_number)
      end
    end
    context 'when random number is invalid once' do
      before do
        allow(player).to receive(:rand).and_return(5, 7)
        allow(random_board).to receive(:column_full?).and_return(true, false)
      end
      it 'runs the loop twice' do
        expect(random_board).to receive(:column_full?).twice
        player.random_column(random_board)
      end
    end
  end
end
