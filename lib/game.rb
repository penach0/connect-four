require_relative 'board'
require_relative 'player'
require_relative 'text_content'
require_relative 'input'

# Represents a single game of Connect 4
class Game
  include TextContent
  include Input
  attr_reader :board, :player_white, :player_black

  def initialize
    @board = Board.new
    @player_white = nil
    @player_black = nil
    @current_player = nil
  end

  def play
    setup
    playing
    game_end
  end

  def setup
    introduction
    create_players
    @current_player = player_white
    print_board
  end

  def playing
    loop do
      turn
      break if game_over?(@current_player.piece)

      change_player
    end
  end

  def game_end
    puts end_message(@current_player.piece)
    Game.new.play if play_again?
  end

  def turn
    @current_player.make_play(board)
    print_board
  end

  def play_again?
    print message(:play_again)
    yes_or_no?
  end

  def game_over?(piece)
    board.win?(piece) || board.draw?(piece)
  end

  def create_players
    first_choice = pick_color
    @player_white = Player.new('⚪', first_choice == '⚪' ? 'human' : opponent_type)
    @player_black = Player.new('⚫', first_choice == '⚫' ? 'human' : opponent_type)
  end

  def opponent_type
    print message(:ask_opponent)
    computer_or_human
  end

  def change_player
    @current_player = (@current_player == player_white ? player_black : player_white)
  end

  def pick_color
    print message(:ask_color)
    black_or_white == 'w' ? '⚪' : '⚫'
  end

  def end_message(piece)
    return message(:victory, piece) if board.win?(piece)
    return message(:draw) if board.draw?(piece)
  end
end
