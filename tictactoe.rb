class Board
  def initialize
      @grid = Array.new(3) { Array.new(3, ' ') }
  end

  def display
      @grid.each do |row|
          puts row.join('|')
          puts '-' * 5
      end
  end

  def place_marker(row, col, marker)
      if @grid[row][col] == ' '
          @grid[row][col] = marker
          return true
      end
      false
  end

  def winner?(marker)
      @grid.any? { |row| row.all?(marker) } ||
      (0..2).any? { |col| @grid.all? { |row| row[col] == marker } } ||
      (0..2).all? { |i| @grid[i][i] == marker } ||
      (0..2).all? { |i| @grid[i][2 - i] == marker }
  end

  def full?
      @grid.flatten.none?(' ')
  end
end

class Player
  attr_reader :name, :marker

  def initialize(name, marker)
      @name = name
      @marker = marker
  end

  def get_move
      loop do
          print "#{@name} (#{@marker}), enter row and column (0-2): "
          input = gets.chomp
          if input.match(/^\d \d$/)
              row, col = input.split.map(&:to_i)
              return [row, col] if row.between?(0, 2) && col.between?(0, 2)
          end
          puts "Invalid input. Please enter two numbers between 0 and 2, separated by a space."
      end
  end
end

class Game
  def initialize
      print "Enter Player 1 name: "
      player1 = Player.new(gets.chomp, 'X')
      print "Enter Player 2 name: "
      player2 = Player.new(gets.chomp, 'O')
      @players = [player1, player2]
      @current_player = @players.first
      @board = Board.new
  end

  def switch_turn
      @current_player = @players.find { |player| player != @current_player }
  end

  def play
      loop do
          @board.display
          row, col = @current_player.get_move
          if @board.place_marker(row, col, @current_player.marker)
              if @board.winner?(@current_player.marker)
                  @board.display
                  puts "#{@current_player.name} wins!"
                  break
              elsif @board.full?
                  @board.display
                  puts "It's a draw!"
                  break
              end
              switch_turn
          else
              puts "Spot already taken. Try again."
          end
      end
  end
end

if __FILE__ == $0
  Game.new.play
end
