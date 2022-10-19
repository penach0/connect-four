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

  def diagonal_down(row, col)
    diagonal = []
    while valid_position?(row, col)
      diagonal << board[row][col]
      row += 1
      col += 1
    end
    diagonal
  end

  def diagonal_up(row, col)
    diagonal = []
    while valid_position?(row, col)
      diagonal << board[row][col]
      row -= 1
      col += 1
    end
    diagonal
  end

  def diagonals_going_down
    diagonals = []

    0.upto(WIDTH - 1) do |column|
      diagonal_top_side = diagonal_down(0, column)
      diagonals << diagonal_top_side unless diagonal_top_side.size < 4
    end

    1.upto(HEIGHT - 1) do |row|
      diagonal_left_side = diagonal_down(row, 0)
      diagonals << diagonal_left_side unless diagonal_left_side.size < 4
    end
    diagonals
  end

  def diagonals_going_up
    diagonals = []

    0.upto(WIDTH - 1) do |column|
      diagonal_bottom_side = diagonal_up(5, column)
      diagonals << diagonal_bottom_side unless diagonal_bottom_side.size < 4
    end

    (HEIGHT - 2).downto(0) do |row|
      diagonal_left_side = diagonal_up(row, 0)
      diagonals << diagonal_left_side unless diagonal_left_side.size < 4
    end
    diagonals
  end

  def diagonals
    diagonals_going_down.concat(diagonals_going_down).sort
  end

  private

  def valid_position?(row, col)
    row.between?(0, HEIGHT - 1) && col.between?(0, WIDTH - 1)
  end
end
