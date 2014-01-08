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
      next if out_of_bounds?(pos)

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