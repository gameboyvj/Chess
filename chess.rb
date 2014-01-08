require "./board.rb"
require "./board_pieces.rb"
require "./piece.rb"

class Chess

  def initialize(name1, name2)
    @board = Board.new
    @players = {:white => HumanPlayer.new(name1, :white),
                :black => HumanPlayer.new(name2, :black)}
  end

  def play

    turn = :white
    until @board.checkmate?(turn)
      @board.render


      @players[turn].play_turn


      turn == :white ? turn = :black : turn = :white
    end

  end
end

class HumanPlayer
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn
    puts "Enter a move (eg 'a2, a4')"
    move_str = gets.chomp
    coords = convert_to_coords(move_str)


  end

  def convert_to_coords(move_str)
    start_str, stop_str = move_str.split(", ")
    start_x = start_str[0].ord - 97
    start_y = 8 - start_str[1].to_i
    stop_x = stop_str[0].ord - 97
    stop_y = 8 - stop_str[1].to_i

    [[start_x, start_y], [stop_x, stop_y]]
  end

end