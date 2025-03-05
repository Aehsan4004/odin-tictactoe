# odin-tictactoe
TIC-TAC-TOE chapter of ODIN

# Tic-Tac-Toe (Command Line Game)

## Overview
This is a simple command-line Tic-Tac-Toe game written in Ruby where two human players take turns to place their marks (X or O) on a 3x3 grid. The game continues until one player wins or the board is full (resulting in a draw). The board is displayed between turns.

## Game Structure
### Classes:
1. **Board**
   - Manages the 3x3 grid.
   - Handles displaying the board.
   - Checks for a win or draw condition.

2. **Player**
   - Stores the player's name and symbol (X or O).
   - Takes input from the player and places it on the board.

3. **Game**
   - Controls the game flow.
   - Alternates turns between players.
   - Checks for win/draw and announces results.

## Class Responsibilities

### Board Class:
#### Instance Variables:
- `@grid`: A 3x3 array representing the game board.

#### Methods:
- `display`: Prints the board.
- `place_marker(row, col, marker)`: Places a marker on the board if the spot is available.
- `winner?(marker)`: Checks if a player has won.
- `full?`: Checks if the board is full.

### Player Class:
#### Instance Variables:
- `@name`: The player's name.
- `@marker`: The symbol ('X' or 'O').

#### Methods:
- `get_move`: Asks the player for a move and validates input.

### Game Class:
#### Instance Variables:
- `@board`: An instance of `Board`.
- `@players`: An array of `Player` instances.
- `@current_player`: Keeps track of whose turn it is.

#### Methods:
- `switch_turn`: Alternates between players.
- `play`: Runs the main game loop.
- `game_over?`: Determines if there's a winner or a draw.

## Game Flow:
1. Initialize the board and players.
2. Display the board.
3. Players take turns making moves.
4. After each move, check for a winner or draw.
5. Announce results and end the game.

## Running the Game
1. Clone the repository.
2. Run `ruby tic_tac_toe.rb` in the terminal.
3. Follow on-screen instructions to play.

## Future Enhancements
- Add AI for single-player mode.
- Implement a scoreboard.
- Allow players to choose their symbols.


