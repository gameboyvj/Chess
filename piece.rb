class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

end

class SlidingPiece < Piece

  def moves


  end

  def get_horizontals
    position_array = []


  end
end