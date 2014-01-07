class Board

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
  end


  def [](x,y)
    @board[y][x]
  end

  def []=(x,y,value)
    @board[y][x] = value
  end

end