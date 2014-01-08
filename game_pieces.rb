class Rook < SlidingPiece
  attr_reader :type

  def initialize(position, board, color)
    super(position, board, color)
    @type = :rook
  end

  def move_dirs
    [[1,0], [-1, 0], [0, 1], [0, -1]]
  end

  def to_s
    @color == :white ? "\u2656".encode : "\u265C".encode
  end
end

class Bishop < SlidingPiece
  attr_reader :type

  def initialize(position, board, color)
    super(position, board, color)
    @type = :bishop
  end

  def move_dirs
    [[1,1], [1,-1], [-1, 1], [-1,-1]]
  end

  def to_s
    @color == :white ? "\u2657".encode : "\u265D".encode
  end

end

class Queen < SlidingPiece
  attr_reader :type

  def initialize(position, board, color)
    super(position, board, color)
    @type = :queen
  end

  def to_s
    @color == :white ? "\u2655".encode : "\u265B".encode
  end
end

class King < SteppingPiece
  attr_reader :type

  def initialize(position, board, color)
    super(position, board, color)
    @type = :king
  end

  def to_s
    @color == :white ? "\u2654".encode : "\u265A".encode
  end
end

class Knight < SteppingPiece
  attr_reader :type

  def initialize(position, board, color)
    super(position, board, color)
    @type = :knight
  end

  def move_dirs
    [[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1]]
  end

  def to_s
    @color == :white ? "\u2658".encode : "\u265E".encode
  end
end

class Pawn < Piece
  attr_reader :type
  attr_accessor :first_move

  def initialize(position, board, color)
    super(position, board, color)
    @type = :pawn
  end

  def to_s
    @color == :white ? "\u2659".encode : "\u265F".encode
  end

  def moves
    deltas = move_dirs
    diag_deltas = deltas.pop(2)

    position_array = get_forward_moves(deltas)
    position_array += get_diag_moves(diag_deltas)

    position_array
  end

  private

  def get_forward_moves(deltas)
    position_array = []

    deltas.each do |delta|
      cur_x, cur_y = @position
      dx, dy = delta[0], delta[1]

      pos = [cur_x + dx, cur_y + dy]
      next if out_of_bounds?(pos)

      if @board[pos].nil?
        position_array << pos
      else
        break
      end
    end
    position_array
  end

  def get_diag_moves(diag_deltas)
    position_array = []

    diag_deltas.each do |delta|
      cur_x, cur_y = @position
      dx, dy = delta[0], delta[1]

      pos = [cur_x + dx, cur_y + dy]
      next if out_of_bounds?(pos)

      position_array << pos if @board[pos] && @board[pos].color != @color
    end

    position_array
  end

  def move_dirs
    if @first_move && @color == :white
      [[0,-1], [0,-2], [-1,-1], [1,-1]]
    elsif @color == :white
      [[0,-1], [-1,-1],[1,-1]]
    elsif @first_move && color == :black
      [[0,1], [0,2], [-1,1], [1,1]]
    else
      [[0,1], [-1,1], [1,1]]
    end
  end

end