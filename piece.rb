require "./board.rb"
require "debugger"

class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(position, board, color)
    @position = position # [x,y]
    @board = board
    @color = color
  end

  def moves
    #raise error

  end

  def out_of_bounds?(pos)
    x,y = pos
    return false if x.between?(0, 7) && y.between?(0,7)
    true
  end


end

class SlidingPiece < Piece

  def moves
    deltas = move_dirs
    position_array = []

    deltas.each do |delta|
      cur_x, cur_y = @position
      dx, dy = delta[0], delta[1]

      n = 1
      loop do
        pos = [cur_x + n*dx, cur_y + n*dy]
        break if out_of_bounds?(pos)

        if @board[pos].nil?
          position_array << pos
        elsif @board[pos].color != @color
          position_array << pos
          break
        else
          break
        end
        n += 1
      end
    end
    position_array
  end

  def move_dirs
    [[1,1], [1,-1], [-1, 1], [-1,-1], [1,0], [-1, 0], [0, 1], [0, -1]]
  end

end

=begin
b=Board.new
p=SteppingPiece.new([5,5], b, :white)
b[[5,5]]=p

p2=SteppingPiece.new([3,5], b, :white)
b[[3,5]]=p2
=end


class SteppingPiece < Piece

  def move_dirs
    [[1,1], [1,-1], [-1, 1], [-1,-1], [1,0], [-1, 0], [0, 1], [0, -1]]
  end

  def moves
    deltas = move_dirs
    position_array = []

    deltas.each do |delta|
      cur_x, cur_y = @position
      dx, dy = delta[0], delta[1]


      pos = [cur_x + dx, cur_y + dy]
      break if out_of_bounds?(pos)

      if @board[pos].nil?
        position_array << pos
      elsif @board[pos].color != @color
        position_array << pos
        break
      else
        break
      end

    end
    position_array
  end

end