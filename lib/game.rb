require_relative 'board'
require_relative 'player'
require_relative 'text_content'

# Represents a single game of Connect 4
class Game
  include TextContent
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    setup
    current_player = @player1
    loop do
      turn(current_player)
      break if game_over?(current_player.piece)

      current_player = change_player(current_player)
    end
    game_end(current_player)
  end

  def setup
    introduction
    create_players(pick_color)
    print_board
  end

  def turn(current_player)
    current_player.make_play(board)
    print_board
  end

  def game_end(current_player)
    puts end_message(current_player.piece)
    Game.new.play if play_again?
  end

  def play_again?
    print message(:play_again)
    loop do
      answer = gets.chomp.downcase
      return true if answer == 'y'
      return false if answer == 'n'

      print message(:invalid_option)
    end
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
    print message(:black_or_white)
    answer = ''
    loop do
      answer = gets.chomp.downcase
      break if %w[w b].include?(answer)

      print message(:invalid_option)
    end
    answer == 'w' ? '⚪' : '⚫'
  end

  def end_message(piece)
    return message(:victory, piece) if board.win?(piece)
    return message(:draw) if board.draw?(piece)
  end
end
