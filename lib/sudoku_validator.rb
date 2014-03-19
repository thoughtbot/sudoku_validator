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


class SubgridValidator
  def initialize(grid)
    modified_grid = subgrids_to_rows(grid)
    @validator = RowValidator.new(modified_grid)
  end

  def valid?
    @validator.valid?
  end

  private

  def subgrids_to_rows(grid)
    grid.each_slice(3).each_with_object([]) do |rows, new_grid|
      new_grid.push(*row_of_subgrids(rows))
    end
  end

  def row_of_subgrids(rows)
    rows.flatten
      .each_slice(3)                        # in triples
      .group_by.with_index { |_, i| i % 3 } # group every third
      .map { |i, e| e.flatten }             # form a row from subgrid elements
  end
end


class SudokuValidator
  def initialize(filename)
    @grid = SudokuFileParser.new(filename).grid
    @complete = !@grid.flatten.any? { |e| e == '.' }
  end

  def valid?
    validators = [RowValidator, ColumnValidator, SubgridValidator]
    validators.all? { |v| v.new(@grid).valid? }
  end

  def complete?
    @complete
  end
end
