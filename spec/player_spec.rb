require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('⚫') }

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
      let(:player_white) { described_class.new('⚪') }
      it 'sets ⚪ as piece' do
        expect(player_white.instance_variable_get('@piece')).to eq('⚪')
      end
    end
  end

  describe '#make_play' do
    context 'when given a number' do
      subject(:board) { instance_double('Board') }

      it 'drops a piece in the corresponding column' do
        piece = player.piece
        column_number = 2
        expect(board).to receive(:update_slot).with(column_number, piece)
        player.make_play(board, column_number)
      end
    end
  end
end
