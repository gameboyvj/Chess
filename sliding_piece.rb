class SlidingPiece < Piece

  def moves
    deltas = move_dirs
    position_array = []

    deltas.each do |delta|
      cur_x, cur_y = @position
      dx, dy = delta[0], delta[1]

      (1..7).each do |n|
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
        
      end
    end
    position_array
  end

  def move_dirs
    #default is all eight directions
    [[1,1], [1,-1], [-1, 1], [-1,-1], [1,0], [-1, 0], [0, 1], [0, -1]]
  end

end
