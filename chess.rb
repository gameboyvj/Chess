#!/Users/appacademy/.rvm/rubies/ruby-1.9.3-p392/bin/ruby

require "./board.rb"
require "./piece.rb"
require "./sliding_piece.rb"
require "./stepping_piece.rb"
require "./game_pieces.rb"
require "./human_player.rb"
require "colorize"
require "./errors.rb"

class Chess
  attr_reader :board, :players

  def initialize(name1 = "Player 1", name2 = "Player 2")
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

        if @board[start].color == turn
          @board.move(start, stop)
        else
          raise WrongPieceError
        end
      rescue WrongPieceError
        puts "Not your piece!"
        retry
      rescue NilPieceError => e
        puts "Invalid start position"
        retry
      rescue InvalidMoveError => f
        puts "Invalid stop position"
        retry
      end

      turn == :white ? turn = :black : turn = :white
    end

    end_condition(turn)
  end

  private
  def end_condition(turn)
    puts "Game over! #{@players[turn].name} is in checkmate."
    @board.render
  end

end


if __FILE__ == $PROGRAM_NAME
  unless ARGV.empty?
    c = Chess.new(ARGV.shift, ARGV.shift)
  else
    c = Chess.new
  end
  c.play
end