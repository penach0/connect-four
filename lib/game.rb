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
    puts 'Congratulations to player ⚪, you won the game!!'
  end

  def turn(current_player)
    current_player.make_play(board)
    print_board
  end

  def setup
    create_players(pick_color)
    print_board
  end

  def game_over?(piece)
    board.win?(piece) || board.draw?
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
end
