require "./piece.rb"
require "./board_pieces.rb"
require "debugger"

class Board

  attr_accessor :piece_catalog

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
    @piece_catalog = []
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
    puts "  #{("a".."h").to_a.join(" ")}"
    @board.each_with_index do |row, index|
      print "#{8-index} "
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
        new_piece = pieces[num].new(pos, self, color)
        self[pos] = new_piece
        @piece_catalog << new_piece
      end
    end

    (0..7).each do |num|
      [:white, :black].each do |color|
        color == :white ? pos = [num,6] : pos = [num, 1]
        new_piece = Pawn.new(pos, self, color)
        self[pos] = new_piece
        @piece_catalog << new_piece
      end
    end
    nil
  end

  def in_check?(color)
    king = @piece_catalog.select {|piece| piece.type == :king && piece.color == color}
    @piece_catalog.each do |piece|
      return true if piece.color != color && piece.moves.include?(king[0].position)
    end
    false
  end

  def dup
    duped_board = Board.new
    (0..7).each do |y|
      (0..7).each do |x|
        if self[[x,y]].nil?
          duped_board[[x,y]] = nil
        else
          duped_board[[x,y]] = self[[x,y]].dup(duped_board)
        end
      end
    end
    duped_board.piece_catalog = []
    @piece_catalog.each do |piece|
      duped_board.piece_catalog << piece.dup(duped_board)
    end
    duped_board
  end

=begin
  b=Board.new
  q=Queen.new([5,5], b, :white)
  k=King.new([5,6], b, :black)
  b.piece_catalog << q
  b.piece_catalog << k
  b.render
  b.in_check?(:black)
=end
  def each_pos!(&blk)
    (0..7).each do |y|
      (0..7).each do |x|
       self[[x,y]] = blk.call(self[[x,y]])
      end
    end
    self
  end

  def move (start, stop)
    piece = self[start]
    raise NoMethodError.new "Invalid start!" if piece.nil?
    if piece.valid_moves.include?(stop)
      make_move(start, stop)
    else
      raise ArgumentError.new "Piece cannot move there!"
    end

    nil
  end

  def make_move(start, stop)
    piece = self[start]
    piece.position = stop
    if self[stop].is_a? Piece
      rem_from_catalog(self[stop])
    end
    self[stop] = piece
    self[start] = nil
    piece.first_move = false
  end

  def rem_from_catalog(dead_piece)
    @piece_catalog.delete(dead_piece)
  end

  def checkmate?(color)
    checkmate = true

    if in_check?(color)
      @piece_catalog.each do |piece|
        if piece.color == color && piece.valid_moves.length > 0
          checkmate = false
        end
      end

    else
      checkmate = false
    end

    checkmate
  end

end



=begin
b = Board.new

q = Queen.new([3,0], b, :black)
k = King.new([4,0],b, :black)
p = Pawn.new([4,1], b, :black)
p2 = Pawn.new([5,2], b, :white)

=end

