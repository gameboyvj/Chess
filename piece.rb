class Piece
  attr_accessor :position, :first_move
  attr_reader :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
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
    self.class.new(@position.dup, dup_board, @color)
  end

end



