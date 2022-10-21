require_relative 'text_content'

# Describes a player of the game
# The game is currently set up for Human vs Computer
# Human plays by picking a column Computer plays random
class Player
  include TextContent
  attr_reader :piece

  def initialize(piece, type)
    @piece = piece
    @type = type
  end

  def make_play(board)
    case @type
    when 'human'
      human_play(board)
    when 'computer'
      computer_play(board)
    end
  end

  def human_play(board)
    board.update_slot(pick_column(board), piece)
  end

  def pick_column(board)
    print message(:pick_number, piece)
    loop do
      column_number = gets.chomp.to_i

      return column_number if board.valid_play?(column_number)

      print message(:invalid_number)
    end
  end

  def computer_play(board)
    puts message(:computer_playing, piece)
    sleep(0.8)
    board.update_slot(random_column(board), piece)
  end

  def random_column(board)
    loop do
      column_number = rand(1..7)
      return column_number unless board.column_full?(column_number)
    end
  end
end
