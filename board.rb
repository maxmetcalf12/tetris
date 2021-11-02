require './piece'

class Board
  attr_accessor :board
  attr_accessor :active_piece
  attr_accessor :score
  attr_accessor :dropdown_speed

  def initialize
    @board = Array.new(20) { Array.new(10) { 0 } }
    @active_piece = Piece.new(location: [0, width / 2])
    @score = 0
    @dropdown_speed = 0.5
  end

  # def board_with_active_piece
  #   temp_board = board.dup
  #   (0...active_piece.height).each do |i|
  #     (0...active_piece.width).each do |j|
  #       next if active_piece.location[0] - i < 0
  #       temp_board[active_piece.location[0] - i][active_piece.location[1] + j] = active_piece.structure[i][j]
  #     end
  #   end
  #   print_board(temp_board)
  # end

  def print_board(board_to_print = board)
    system("clear")
    system('cls')
    (0...board.length).each do |row|
      board_row = "||"
      (0...board[0].length).each do |column|
        if active_piece_coordinates.include?([row, column])
          board_row << ' 1 '
        else
          board_row << " #{board[row][column] == 0 ? ' ' : '1'} "
        end
      end
      if row == 1
        puts board_row += "||              SCORE: #{score}"
      else
        puts board_row += "||"
      end
    end
  end

  def active_piece_coordinates
    coordinates = []
    (0...active_piece.height).each do |i|
      (0...active_piece.width).each do |j|
        coordinates << [active_piece.location[0] - i, active_piece.location[1] + j] if active_piece.structure[i][j] == 1
      end
    end

    coordinates
  end

  def height
    board.length
  end

  def width
    board[0].length
  end

  def rotate_active_piece(direction)
    previous_structure = active_piece.structure
    active_piece.rotate(direction)
    active_piece.structure = previous_structure if active_piece_invalid?
    
    print_board
  end

  def move_active_piece(direction)
    previous_location = active_piece.location
    active_piece.move(direction)
    if active_piece_invalid?
      active_piece.location = previous_location 

      if direction == 'down'
        set_active_piece
      else
      end
    end

    print_board
  end

  def active_piece_invalid?
    (0...active_piece.height).each do |i|
      (0...active_piece.width).each do |j|
        if active_piece.structure[i][j] == 1
          row = active_piece.location[0] - i
          column = active_piece.location[1] + j
          return true if column >= width || row >= height || board[row][column] == 1
        end
      end
    end

    false
  end

  def set_active_piece
    (0...active_piece.height).each do |i|
      (0...active_piece.width).each do |j|
        board[active_piece.location[0] - i][active_piece.location[1] + j] = 1 if active_piece.structure[i][j] == 1
      end
    end

    @active_piece = Piece.new(location: [0, width / 2])
    check_rows_for_completion
  end

  def check_rows_for_completion
    board.each_with_index do |row, i|
      if row.all?(1)
        board.delete_at(i)
        board.unshift(Array.new(10, 0))
        @score += 1
        @dropdown_speed = dropdown_speed * 0.8
      end
    end
  end
end