# This module holds simple methods for getting input from the user
module Input
  def yes_or_no?
    loop do
      answer = gets.chomp.downcase
      return true if answer == 'y'
      return false if answer == 'n'

      print message(:invalid_option)
    end
  end

  def black_or_white
    loop do
      answer = gets.chomp.downcase
      return answer if %w[w b].include?(answer)

      print message(:invalid_option)
    end
  end
end
