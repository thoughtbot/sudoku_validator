class SudokuValidator
  attr_reader :grid
  DIVISIONS = %i[row column subgrid]

  def initialize(squares)
    @grid = Grid.new(normalize(squares))
  end

  def valid?
    DIVISIONS.all? { |division| valid_division?(division) }
  end

  def complete?
    @grid.squares.none? { |square| square == "." }
  end

  def uniq?(array)
    array = array.reject { |square| square == "." }
    array.uniq.length == array.length
  end

  def normalize(squares)
    case squares
    when String
      squares.split(/[^\d\.]+/)
    else
      Array(squares)
    end
  end

  def to_a
    @grid.squares
  end

  private

  def valid_division?(division)
    (0...@grid.edge_length).all? do |i|
      values = @grid.send(division, i)
      uniq?(values)
    end
  end
end
