require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    context 'when board is initialized' do
      it 'has a board attribute' do
        expect(board).to have_attributes(board: Array)
      end

      it 'has 6 rows' do
        expect(board.board.size).to eq(6)
      end

      it 'has 7 columns' do
        expect(board.board[0].size).to eq(7)
      end
    end
  end

  describe '#column' do
    context 'when a column is empty' do
      it 'returns the column' do
        column = ['  '] * 6
        expect(board.column(3)).to eq(column)
      end
    end
    context 'when a column has pieces' do
      subject(:played_board) do
        described_class.new([['  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '⚪', '  ', '  ', '  ', '  '],
                             ['  ', '⚫', '  ', '  ', '  ', '  ']])
      end

      it 'returns the column' do
        column = ['  ', '  ', '  ', '  ', '⚪', '⚫']
        expect(played_board.column(2)).to eq(column)
      end
    end
  end
end
