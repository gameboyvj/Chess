class HumanPlayer
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn
    puts "#{name}, enter a move (eg 'a2, a4')"
    move_str = gets.chomp
    coords = convert_to_coords(move_str)
  end

  def convert_to_coords(move_str)
    move_str.gsub!(" ","")
    start_str, stop_str = move_str.split(",")
    start_x = start_str[0].ord - 97
    start_y = 8 - start_str[1].to_i
    stop_x = stop_str[0].ord - 97
    stop_y = 8 - stop_str[1].to_i

    [[start_x, start_y], [stop_x, stop_y]]
  end

end