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
end