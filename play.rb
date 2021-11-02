require './board'
require 'io/console'

board = Board.new

playing = true

Thread.new do
  i = 0
  while true do
    p "\n"
    i += 1
    system("stty -raw echo")
    board.move_active_piece("down")
    system("stty raw -echo")
    sleep board.dropdown_speed
  end
end

while playing
  command = STDIN.getch
  case command
  when "a"
    board.move_active_piece("left")
  when "f"
    board.move_active_piece("right")
  when "s"
    board.rotate_active_piece("cw")
  when "d"
    board.move_active_piece("down")
  when 'q'
    playing = false
  end
end
