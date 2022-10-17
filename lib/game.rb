require_relative 'player'

# Represents a single game of Connect 4
class Game
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
end
