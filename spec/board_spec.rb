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

  describe '#column_full?' do
    subject(:column_board) do
      described_class.new([['  ', '⚪', '  ', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '  ', '  ', '  '],
                           ['  ', '⚪', '  ', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '  ', '  ', '  '],
                           ['  ', '⚪', '  ', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '  ', '  ', '  ']])
    end
    context 'when the given column is full' do
      it 'returns true' do
        expect(column_board).to be_column_full(2)
      end
    end
    context 'when the given column is not full' do
      it 'returns false' do
        expect(column_board).not_to be_column_full(1)
      end
    end
  end

  describe '#board_full?' do
    subject(:full_board) do
      described_class.new([['⚪', '⚪', '⚫', '⚪', '⚪', '⚫'],
                           ['⚪', '⚪', '⚫', '⚪', '⚪', '⚪'],
                           ['⚪', '⚫', '⚫', '⚪', '⚫', '⚫'],
                           ['⚫', '⚪', '⚪', '⚫', '⚪', '⚫'],
                           ['⚪', '⚪', '⚫', '⚪', '⚪', '⚪'],
                           ['⚪', '⚪', '⚫', '⚪', '⚪', '⚫']])
    end
    context 'when the board is full' do
      it 'returns true' do
        expect(full_board).to be_board_full
      end
    end
    context 'when board is not full' do
      it 'returns false' do
        expect(board).not_to be_board_full
      end
    end
  end

  describe '#playable_slot' do
    subject(:playable_board) do
      described_class.new([['  ', '  ', '  ', '⚪', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  '],
                           ['  ', '  ', '  ', '⚫', '  ', '  '],
                           ['  ', '⚪', '  ', '⚫', '  ', '  '],
                           ['  ', '⚫', '  ', '⚫', '  ', '  ']])
    end
    context 'when column is empty' do
      it 'returns the bottom slot' do
        expect(playable_board.playable_slot(1)).to eq(5)
      end
    end
    context 'when column is played' do
      it 'returns the lowest available slot' do
        expect(playable_board.playable_slot(2)).to eq(3)
      end
    end
  end
end
