class Board
  attr_reader :board

  HEIGHT = 6
  WIDTH = 7

  def initialize(board = nil)
    @board = board || Array.new(HEIGHT) { Array.new(WIDTH, '  ') }
  end

  def column(number)
    columns = board.transpose
    columns[number - 1]
  end

  def column_full?(number)
    column(number).first != '  '
  end

  def board_full?
    board.first.none? { |slot| slot == '  ' }
  end

  def playable_slot(number)
    return if column_full?(number)

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
end
