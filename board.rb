require "./piece.rb"
require "./board_pieces.rb"
require "debugger"

class Board

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
    setup
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
          print value.to_s+" "
        end
      end
      puts
    end

    nil
  end

  def setup
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    (0..7).each do |num|
      [:white, :black].each do |color|
        color == :white ? pos = [num,7] : pos = [num, 0]
        self[pos]= pieces[num].new(pos, self, color)
      end
    end

    (0..7).each do |num|
      [:white, :black].each do |color|
        color == :white ? pos = [num,6] : pos = [num, 1]
        self[pos]= Pawn.new(pos, self, color)
      end
    end
    nil
  end

  def in_check


  end


  def each_pos(&blk)
    (0..7).each do |y|
      (0..7).each do |x|
       blk.call(self[[x,y]])
      end
    end
    self
  end


end

=begin
b = Board.new

q = Queen.new([3,0], b, :black)
k = King.new([4,0],b, :black)
p = Pawn.new([4,1], b, :black)
p2 = Pawn.new([5,2], b, :white)

=end

