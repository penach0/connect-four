<<<<<<< HEAD
# Ruby on Replit

This is a template to get you started with Ruby on Replit. It's ready to go so you can just hit run and start coding!

## Running the repl

Simply hit run! You can edit the run command from the `.replit` file.

## Installing packages

To add packages to your repl, we recommend using the Replit packager interface in the left sidebar or using `bundle install` in the shell. Check out the [Bundle docs here](https://bundler.io/v2.3/#getting-started).

**Warning: Avoid using `gem install` to add packages.**

Beacuse Ruby repls use [Bundle](https://bundler.io/) under the hood to provide a consistent environment that tracks and installs the exact gems and versions needed, we recommend using `bundle install` instead of `gem install`, which may not work as expected.

## Help

If you need help you might be able to find an answer on our [docs](https://docs.replit.com) page. Feel free to report bugs and give us feedback [here](https://replit.com/support).
=======
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
>>>>>>> 65d45f1 (Add README)
