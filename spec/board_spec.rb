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
        described_class.new([['  ', '  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '  ', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '⚪', '  ', '  ', '  ', '  ', '  '],
                             ['  ', '⚫', '  ', '  ', '  ', '  ', '  ']])
      end

      it 'returns the column' do
        column = ['  ', '  ', '  ', '  ', '⚪', '⚫']
        expect(played_board.column(2)).to eq(column)
      end
    end
  end

  describe '#column_full?' do
    subject(:column_board) do
      described_class.new([['  ', '⚪', '  ', '  ', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '  ', '  ', '  ', '  '],
                           ['  ', '⚪', '  ', '  ', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '  ', '  ', '  ', '  '],
                           ['  ', '⚪', '  ', '  ', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '  ', '  ', '  ', '  ']])
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
      described_class.new([['⚪', '⚪', '⚫', '⚪', '⚪', '⚫', '⚫'],
                           ['⚪', '⚪', '⚫', '⚪', '⚪', '⚪', '⚪'],
                           ['⚪', '⚫', '⚫', '⚪', '⚫', '⚫', '⚫'],
                           ['⚫', '⚪', '⚪', '⚫', '⚪', '⚫', '⚪'],
                           ['⚪', '⚪', '⚫', '⚪', '⚪', '⚪', '⚫'],
                           ['⚪', '⚪', '⚫', '⚪', '⚪', '⚫', '⚪']])
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

  describe '#valid_play?' do
    subject(:valid_board) do
      described_class.new([['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚫', '  ', '  ', '  '],
                           ['  ', '⚪', '  ', '⚫', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '⚫', '  ', '  ', '  ']])
    end
    context 'when column is full' do
      it 'returns false' do
        expect(valid_board).not_to be_valid_play(4)
      end
    end

    context 'when the number is outside of range' do
      it 'returns false' do
        expect(valid_board).not_to be_valid_play(9)
      end
    end

    context 'when the the play is valid' do
      it 'returns true' do
        expect(valid_board).to be_valid_play(1)
      end
    end
  end

  describe '#playable_slot' do
    subject(:playable_board) do
      described_class.new([['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚫', '  ', '  ', '  '],
                           ['  ', '⚪', '  ', '⚫', '  ', '  ', '  '],
                           ['  ', '⚫', '  ', '⚫', '  ', '  ', '  ']])
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

  describe '#update_slot' do
    context 'when given a column' do
      it 'updates the value of the playable slot to ⚪' do
        column = 1
        piece = '⚪'
        board.update_slot(column, piece)
        expect(board.board[5][1]).to eq(piece)
      end

      it 'updates the value of the playable slot to ⚫' do
        column = 2
        piece = '⚫'
        board.update_slot(column, piece)
        expect(board.board[5][2]).to eq(piece)
      end
    end
  end

  describe '#horizontal_win?' do
    subject(:horizontal_board) do
      described_class.new([['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚫', '  ', '  ', '  '],
                           ['  ', '⚪', '⚫', '⚫', '⚫', '⚫', '  '],
                           ['  ', '⚫', '⚫', '⚪', '⚫', '⚪', '  ']])
    end
    context 'when there is an horizontal win on the board' do
      it 'returns true' do
        expect(horizontal_board.horizontal_win?('⚫')).to be true
      end
    end
  end

  describe '#vertical_win?' do
    subject(:vertical_board) do
      described_class.new([['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '⚪', '⚪', '⚫', '⚫', '⚫', '  '],
                           ['  ', '⚫', '⚫', '⚪', '⚫', '⚪', '  ']])
    end
    context 'when there is a vertical win on the board' do
      it 'returns true' do
        expect(vertical_board.vertical_win?('⚪')).to be true
      end
    end
  end

  context 'when fecthing the diagonals' do
    subject(:diagonal_board) do
      described_class.new([['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚪', '  ', '  ', '  '],
                           ['  ', '  ', '  ', '⚫', '  ', '  ', '  '],
                           ['  ', '⚪', '⚫', '⚫', '⚫', '⚫', '  '],
                           ['  ', '⚫', '⚫', '⚪', '⚫', '⚪', '  ']])
    end
    describe '#diagonal_down' do
      context 'when given coordinates [0,0]' do
        it 'returns the corresponding diagonal' do
          diagonal = ['  ', '  ', '  ', '⚫', '⚫', '⚪']
          expect(diagonal_board.diagonal_down(0, 0)).to eq(diagonal)
        end
      end
      context 'when given coordinates [2,0]' do
        it 'returns the corresponding diagonal' do
          diagonal = ['  ', '  ', '⚫', '⚪']
          expect(diagonal_board.diagonal_down(2, 0)).to eq(diagonal)
        end
      end
      context 'when given coordinates [0,3]' do
        it 'returns the corresponding diagonal' do
          diagonal = ['⚪', '  ', '  ', '  ']
          expect(diagonal_board.diagonal_down(0, 3)).to eq(diagonal)
        end
      end
    end

    describe '#diagonal_up' do
      context 'when given coordinates [0,6]' do
        it 'returns the correct diagonal' do
          diagonal = ['⚫', '⚫', '⚫', '  ', '  ', '  ']
          expect(diagonal_board.diagonal_up(5, 1)).to eq(diagonal)
        end
      end
    end

    describe '#diagonals_going_down' do
      it 'returns an array the diagonals going down that have size > 4' do
        diagonals_down = [['  ', '  ', '  ', '⚫', '⚫', '⚪'], ['  ', '  ', '⚪', '  ', '⚫', '  '],
                          ['  ', '⚪', '  ', '  ', '  '], ['⚪', '  ', '  ', '  '],
                          ['  ', '  ', '  ', '⚫', '⚫'], ['  ', '  ', '⚫', '⚪']]

        expect(diagonal_board.diagonals_going_down).to eq(diagonals_down)
      end
    end

    describe '#diagonals_going_up' do
      it 'returns an array the diagonals going up that have size > 4' do
        diagonals_up = [['  ', '⚪', '  ', '⚪', '  ', '  '], ['⚫', '⚫', '⚫', '  ', '  ', '  '],
                        ['⚫', '⚫', '  ', '  ', '  '], ['⚪', '⚫', '  ', '  '],
                        ['  ', '  ', '  ', '⚪', '  '], ['  ', '  ', '  ', '⚪']]

        expect(diagonal_board.diagonals_going_up).to eq(diagonals_up)
      end
    end
  end
end
