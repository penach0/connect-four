class Board
  attr_reader :board

  def initialize(board = nil)
    @board = board || Array.new(6) { Array.new(7, '  ') }
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
end
