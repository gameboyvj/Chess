require "./piece.rb"

class Board

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
  end


  def [](pos)
    x,y = pos
    @board[y][x]
  end

  def []=(pos,value)
    x,y = pos
    @board[y][x] = value
  end

  def render
    @board.each do |row|
      row.each do |value|
        if value.nil?
          print "_ "
        else
          print "P "
        end
      end
      puts
    end
  end

end