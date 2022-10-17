require_relative 'board'
require_relative 'player'

# Represents a single game of Connect 4
class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def setup
    create_players(pick_color)
    print_board
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

  def pick_color
    print 'Play as White or Black (w/b): '
    loop do
      answer = gets.chomp.downcase
      break if %w[w b].include?(answer)

      print 'Please pick a valid option: '
    end
    answer == 'w' ? '⚪' : '⚫'
  end

  def pick_column(current_player)
    print "#{current_player.piece} playing. Pick a number: "
    loop do
      column_number = gets.chomp.to_i

      break current_player.make_play(board, column_number) if board.playable_slot(column_number)

      print 'Not valid, pick another one: '
    end

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
