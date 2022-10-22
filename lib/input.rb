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

  def pick_number(board)
    loop do
      column_number = gets.chomp.to_i
      return column_number if board.valid_play?(column_number)

      print message(:invalid_number)
    end
  end

  def computer_or_human
    loop do
      answer = gets.chomp.downcase
      return answer if %w[computer human].include?(answer)

      print message(:invalid_option)
    end
  end
end
