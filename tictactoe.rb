# frozen_string_literal: true

# Tic-Tac-Toe Game
# A simple command-line Tic-Tac-Toe game where two human players take turns to place their marks (X or O) on a 3x3 grid.

# Board class manages the game board, checks for a winner, and handles moves.
class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, ' ') }
  end

  def display
    @grid.each_with_index do |row, index|
      puts row.join('|')
      puts '-' * 5 unless index == 2
    end
  end

  def place_marker(row, col, marker)
    return false unless @grid[row - 1][col - 1] == ' '

    @grid[row - 1][col - 1] = marker
    true
  end

  def winner?(marker)
    winning_rows?(marker) || winning_cols?(marker) || winning_diagonals?(marker)
  end

  def full?
    @grid.flatten.none?(' ')
  end

  private

  def winning_rows?(marker)
    @grid.any? { |row| row.all?(marker) }
  end

  def winning_cols?(marker)
    @grid.transpose.any? { |col| col.all?(marker) }
  end

  def winning_diagonals?(marker)
    (0..2).all? { |i| @grid[i][i] == marker } || (0..2).all? { |i| @grid[i][2 - i] == marker }
  end
end

# Player class stores player name and marker, and handles move input.
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def move
    loop do
      print "#{@name} (#{@marker}), enter row and column (1-3): "
      input = gets.chomp
      unless valid_input?(input)
        next puts 'Invalid input. Please enter two numbers between 1 and 3, separated by a space.'
      end

      row, col = input.split.map(&:to_i)
      return [row, col] if row.between?(1, 3) && col.between?(1, 3)
    end
  end

  private

  def valid_input?(input)
    input.match(/^\d \d$/)
  end
end

# Game class manages the game flow, switching turns, and determining the winner.
class Game
  def initialize
    @players = create_players
    @current_player = @players.first
    @board = Board.new
  end

  def play
    loop do
      @board.display
      row, col = @current_player.move
      next puts 'Spot already taken. Try again.' unless @board.place_marker(row, col, @current_player.marker)
      break display_winner if @board.winner?(@current_player.marker)
      break display_draw if @board.full?

      switch_turn
    end
  end

  private

  def create_players
    print 'Enter Player 1 name: '
    player1 = Player.new(gets.chomp, 'X')
    print 'Enter Player 2 name: '
    player2 = Player.new(gets.chomp, 'O')
    [player1, player2]
  end

  def switch_turn
    @current_player = @players.find { |player| player != @current_player }
  end

  def display_winner
    @board.display
    puts "#{@current_player.name} wins!"
  end

  def display_draw
    @board.display
    puts "It's a draw!"
  end
end

# Start the game if the script is run directly.
Game.new.play if __FILE__ == $PROGRAM_NAME
