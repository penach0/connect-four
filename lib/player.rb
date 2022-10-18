class Player
  attr_reader :piece

  def initialize(piece, type)
    @piece = piece
    @type = type
  end

  def make_play(board)
    case @type
    when 'human'
      board.update_slot(pick_column(board), piece)
    when 'computer'
      board.update_slot(random_column(board), piece)
    end
  end

  # Human play
  def pick_column(board)
    print "#{piece} playing. Pick a number: "
    loop do
      column_number = gets.chomp.to_i

      return column_number if board.valid_play?(column_number)

      print 'Not valid, pick another one: '
    end
  end

  # Computer play
  def random_column(board)
    loop do
      column_number = rand(1, 7)
      return column_number unless board.column_full?(column_number)
    end
  end
end
