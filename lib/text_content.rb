# This module will hold text content for message display
module TextContent
  INTRODUCTION = <<~HEREDOC.freeze




    .g8"""bgd                                                  mm
    .dP'     `M                                                  MM
    dM'       ` ,pW"Wq.`7MMpMMMb.  `7MMpMMMb.  .gP"Ya   ,p6"bo mmMMmm          ,AM
    MM         6W'   `Wb MM    MM    MM    MM ,M'   Yb 6M'  OO   MM           AVMM
    MM.        8M     M8 MM    MM    MM    MM 8M"""""" 8M        MM         ,W' MM
    `Mb.     ,'YA.   ,A9 MM    MM    MM    MM YM.    , YM.    ,  MM       ,W'   MM
      `"bmmmd'  `Ybmd9'.JMML  JMML..JMML  JMML.`Mbmmd'  YMbmd'   `Mbmo    AmmmmmMMmm
                                                                                MM
                                                                                MM





    Press enter to continue:
  HEREDOC

  def introduction
    puts INTRODUCTION
    gets.chomp
  end

  def message(message, piece = nil)
    {
      pick_number: "#{piece} playing. Pick a number: ",
      invalid_number: 'Not valid, pick another one: ',
      black_or_white: 'Play as White or Black (w/b): ',
      invalid_option: 'Please pick a valid option: ',
      victory: "Congratulations to player #{piece}, you won the game!!",
      draw: 'The game is drawn, good play by both players!',
      play_again: 'Do you want to play again (Y/N)? '
    }[message]
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
