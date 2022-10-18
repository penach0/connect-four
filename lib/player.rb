class Player
  attr_reader :piece

  def initialize(piece, type)
    @piece = piece
    @type = type
  end

  def make_play(board, column)
    board.update_slot(column, piece)
  end

  def pick_column(board)
    print "#{piece} playing. Pick a number: "
    loop do
      column_number = gets.chomp.to_i

      return column_number if board.valid_play?(column_number)

      print 'Not valid, pick another one: '
    end
  end
end
