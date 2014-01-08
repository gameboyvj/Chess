require "./board.rb"
require "./board_pieces.rb"
require "debugger"

class Piece
  attr_accessor :position, :first_move
  attr_reader :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
    #@board[position]=self
    @first_move = true
  end

  def moves
    #raise error

  end

  def out_of_bounds?(pos)
    x,y = pos
    return false if x.between?(0, 7) && y.between?(0,7)
    true
  end

  def valid_moves
    #take the piece's moves,
    #executes each one on a duped board, checks board.in_check?
    valid_moves = []
    #debugger
    possible_moves = self.moves
    possible_moves.each do |move|
      duped_board = @board.dup
      duped_board.make_move(self.position, move)
      unless duped_board.in_check?(self.color)
        valid_moves << move
      end
    end

    valid_moves
  end

  def dup(dup_board)
    duped_piece = self.class.new(@position.dup, dup_board, @color)
  end

end
=begin
b.move([5,6],[5,5])
b.move([4,1],[4,3])
b.move([6,6], [6,4])
b.move([3,0],[7,4])


=end
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