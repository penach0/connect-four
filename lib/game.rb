require_relative 'player'

class Game
  def create_players
    player1 = Player.new('⚪')
    player2 = Player.new('⚫')
  end
end