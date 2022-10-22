require_relative 'board'
require_relative 'player'
require_relative 'text_content'
require_relative 'input'

# Represents a single game of Connect 4
class Game
  include TextContent
  include Input
  attr_reader :board

  def initialize
    @board = Board.new
    @winner = nil
  end

  def play
    setup
    playing
    game_end
  end

  def setup
    introduction
    create_players(pick_color)
    print_board
  end

  def playing
    current_player = @player1
    loop do
      turn(current_player)
      break if game_over?(current_player.piece)

      current_player = change_player(current_player)
    end
    @winner = current_player
  end

  def game_end
    puts end_message(@winner.piece)
    Game.new.play if play_again?
  end

  def turn(current_player)
    current_player.make_play(board)
    print_board
  end

  def play_again?
    print message(:play_again)
    yes_or_no?
  end

  def game_over?(piece)
    board.win?(piece) || board.draw?(piece)
  end

  def create_players(color)
    other_color = (color == '⚪' ? '⚫' : '⚪')
    if color == '⚪'
      @player1 = Player.new(color, 'human')
      @player2 = Player.new(other_color, 'computer')
    else
      @player1 = Player.new(other_color, 'computer')
      @player2 = Player.new(color, 'human')
    end
  end

  def change_player(current_player)
    current_player == @player1 ? @player2 : @player1
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
