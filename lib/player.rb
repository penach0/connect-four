require_relative 'text_content'
require_relative 'input'

# Describes a player of the game
# The game is currently set up for Human vs Computer
# Human plays by picking a column Computer plays random
class Player
  include TextContent
  include Input
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
    print message(:ask_number, piece)
    pick_number(board)
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
