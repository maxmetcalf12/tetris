class Piece
  attr_accessor :structure
  attr_accessor :location

  PIECES = [
    [
      [1, 1, 1, 1]
    ],
    [
      [1, 1, 1],
      [1, 0, 0]
    ],
    [
      [1, 1, 1],
      [0, 0, 1]
    ],
    [
      [1, 1, 0],
      [0, 1, 1]
    ],
    [
      [0, 1, 1],
      [1, 1, 0]
    ],
    [
      [1, 1, 1],
      [0, 1, 0]
    ],
    [
      [1, 1],
      [1, 1]
    ]
  ]
  
  def initialize(args)
    @structure = PIECES.sample
    @location = [args[:location][0], args[:location][1] - (width / 2)]
  end

  def height
    structure.length
  end

  def width
    structure[0].length
  end

  def move(direction)
    case direction
    when "left"
      @location = [location[0], location[1] - 1] unless location[1] == 0
    when "right"
      @location = [location[0], location[1] + 1]
    when "down"
      @location = [location[0] + 1, location[1]]
    end
  end

  def rotate(direction)
    case direction
    when "cw"
      @structure = rotate_structure_cw
    when "ccw"
      @location = [location[0], location[1] + 1]
    end
  end

  def rotate_structure_cw
    @structure = structure.transpose.map(&:reverse)
  end
end