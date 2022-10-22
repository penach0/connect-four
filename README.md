# connect-four
Implementation of the classic game Connect Four on the command line. Written in Ruby.
In this project I will explore the TDD methodology

## Instructions

- Choose your color piece (Black or White, white always goes first)
- Choose your opponent type (Computer or another human)
- Make a play by picking the number of the column where you want to drop a piece.
The piece will occupy the first available slot from the bottom
- Take turns between players dropping pieces of their respective color
- Try to connect 4 pieces of your color in any direction! (vertical, horizontal or
diagonal)
- First player to connect 4 wins
- If no player connected 4 and the board is full the game ends in a draw

## Takeaways


### Lessons learned:

- Utilizing dependency injection for testing
- First time using Reek (code smell detector). Learned about code smells and tried to fix them
as they came
- Feel like my OOP design is getting better (even if far from good) as well as my code 
refactoring, especially extracting methods to shorten methods and remove duplication

### To do:

- Need to get better at deciding what to make private in a class
- Decide which methods are necessary vs unnecessary (testing behavior vs implementation)
