class SudokuValidator

  def self.valid_array?(array)
    array_with_numbers_only = array.reject { |el| el == "." }
    array_with_numbers_only.uniq.length == array_with_numbers_only.length
  end

  def self.complete_array?(array)
    array_with_numbers_only = array.reject { |el| el == "." }
    array_with_numbers_only.length == 9
  end

  attr_reader :grid

  def initialize(grid_or_filepath)
    if grid_or_filepath.instance_of? String
      reader = SudokuReader.new
      reader.read grid_or_filepath
      @grid = reader.grid
    else
      @grid = grid_or_filepath
    end
  end

  def row(i)
    grid[i-1]
  end

  def column(i)
    grid.map { |row| row[i-1] }
  end

  # subgrid is laid out as below
  #       1       2       3   <- grid_column_index
  #     1 - 3   4 - 6   7 - 9
  #   1 . . . | . . . | . . .
  # 1 | . 1 . | . 2 . | . 3 .
  #   3 . . . | . . . | . . .
  #     +-----+-------+-----+
  #   4 . . . | . . . | . . .
  # 2 | . 4 . | . 5 . | . 6 .
  #   6 . . . | . . . | . . .
  #     +-----+-------+-----+
  #   7 . . . | . . . | . . .
  # 3 | . 7 . | . 8 . | . 9 .
  #   9 . . . | . . . | . . .
  #
  # ^
  # grid_row_index
  #
  def subgrid(i)
    
    grid_row_index = (i - 1) / 3 + 1

    grid_column_index = ( i - 1) % 3 + 1

    row_begin = (grid_row_index - 1) * 3 + 1
    row_end = grid_row_index * 3

    column_begin = (grid_column_index - 1) * 3 + 1
    column_end = grid_column_index * 3

    subgrid_array = []
    (row_begin..row_end).each do |ri|
      (column_begin..column_end).each do |ci|
        subgrid_array << grid[ri-1][ci-1]
      end
    end
    subgrid_array
  end

  def valid?
    (1..9).all? { |i| SudokuValidator.valid_array?(row(i)) } and 
    (1..9).all? { |i| SudokuValidator.valid_array?(column(i)) } and
    (1..9).all? { |i| SudokuValidator.valid_array?(subgrid(i)) }
  end

  def complete?
    (1..9).all? { |i| SudokuValidator.complete_array?(row(i)) } and 
    (1..9).all? { |i| SudokuValidator.complete_array?(column(i)) } and
    (1..9).all? { |i| SudokuValidator.complete_array?(subgrid(i)) }
  end
end