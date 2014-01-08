require "./board.rb"
require "./piece.rb"
require "./sliding_piece.rb"
require "./stepping_piece.rb"
require "./game_pieces.rb"
require "./human_player.rb"
require "colorize"

class Chess
  attr_reader :board, :players

  def initialize(name1, name2)
    @board = Board.new
    @players = {:white => HumanPlayer.new(name1, :white),
                :black => HumanPlayer.new(name2, :black)}
  end

  def play
    turn = :white
    until @board.checkmate?(turn)
      @board.render

      begin
        start, stop = @players[turn].play_turn
        @board.move(start, stop)
      rescue NoMethodError => e
        puts "Invalid start position"
        retry
      rescue ArgumentError => f
        puts "Invalid stop position"
        retry
      end

      turn == :white ? turn = :black : turn = :white
    end

    puts "Game over! #{@players[turn].name} lost."
    @board.render
  end
end


if __FILE__ == $PROGRAM_NAME
  c = Chess.new(ARGV.shift, ARGV.shift)
  c.play
end