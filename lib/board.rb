class Board
  attr_reader :board, :columns

  HEIGHT = 6
  WIDTH = 7

  def initialize(board = nil)
    @board = board || Array.new(HEIGHT) { Array.new(WIDTH, '  ') }
    @columns = @board.transpose
  end

  def column(number)
    columns[number - 1]
  end

  def column_full?(number)
    column(number).first != '  '
  end

  def board_full?
    board.first.none? { |slot| slot == '  ' }
  end

  def valid_play?(number)
    number.between?(1, 7) && !column_full?(number)
  end

  def playable_slot(number)
    column = column(number)
    column.each_index do |index|
      return index if column[index + 1] != '  '
    end
  end

  def update_slot(number, piece)
    column = number
    row = playable_slot(number)
    board[row][column] = piece
  end

  def horizontal_win?(piece)
    count_pieces(piece, board)
  end

  def vertical_win?(piece)
    count_pieces(piece, columns)
  end

  def count_pieces(piece, direction)
    count = 0

    direction.each do |line|
      next if line.count(piece) < 4

      line.each do |slot|
        slot == piece ? count += 1 : count = 0
        return true if count == 4
      end
    end
    false
  end
end
