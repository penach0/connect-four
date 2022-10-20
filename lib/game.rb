require_relative 'board'
require_relative 'player'

# Represents a single game of Connect 4
class Game
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
    puts end_message(current_player.piece)
    Game.new.play if play_again?
  end

  def turn(current_player)
    current_player.make_play(board)
    print_board
  end

  def setup
    create_players(pick_color)
    print_board
  end

  def play_again?
    print 'Do you want to play again? '
    loop do
      answer = gets.chomp.downcase
      return true if answer == 'y'
      return false if answer == 'n'

      print 'Not valid, try again: '
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
    print 'Play as White or Black (w/b): '
    answer = ''
    loop do
      answer = gets.chomp.downcase
      break if %w[w b].include?(answer)

      print 'Please pick a valid option: '
    end
    answer == 'w' ? '⚪' : '⚫'
  end

  def print_board
    top = '   ➊  ➋  ➌  ➍  ➎  ➏  ➐'
    base = ' ╱╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲╲'

    puts top
    board.board.each do |row|
      puts "  ┃#{row.join('|')}┃"
    end
    puts base
  end

  def end_message(piece)
    return "Congratulations to player #{piece}, you won the game!!" if board.win?(piece)
    return 'The game is drawn, good play by both players!' if board.draw?(piece)
  end
end
