class SudokuFileParser
  attr_reader :grid

  def initialize(filename)
    contents = IO.read(filename)
    stripped = strip_unnecessary(contents)
    @grid = gridify(stripped)
  end

  private

  def strip_unnecessary(contents)
    contents.gsub(/[^\d\.]/, '')
  end

  def gridify(stripped)
    stripped.chars.each_slice(9).to_a
  end
end

class RowValidator
  def initialize(grid)
    @stripped_grid = strip_dots(grid)
  end

  def valid?
    @stripped_grid.all? { |row| row.uniq.size == row.size }
  end

  private

  def strip_dots(grid)
    grid.map do |row|
      row.reject { |e| e == '.' }
    end
  end
end

class ColumnValidator
  def initialize(grid)
    @validator = RowValidator.new(grid.transpose)
  end

  def valid?
    @validator.valid?
  end
end
