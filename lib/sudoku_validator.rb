class SudokuValidator

  def self.valid_array?(array)
    array_with_numbers_only = array.reject { |el| el == "." }
    array_with_numbers_only.uniq.length == array_with_numbers_only.length
  end

  def self.complete_array?(array)
    array_with_numbers_only = array.reject { |el| el == "." }
    array_with_numbers_only.length == 9
  end

  def self.array_is?(validation_type, array)
    if validation_type == :invalid
      not valid_array? array
    else
      not complete_array? array
    end
  end

  attr_reader :grid
  attr_reader :errors

  def initialize(grid_or_filepath)
    if grid_or_filepath.instance_of? String
      reader = SudokuReader.new
      reader.read grid_or_filepath
      @grid = reader.grid
    else
      @grid = grid_or_filepath
    end
    @errors = {
      invalid: {
        column: [],
        row: [],
        subgrid: []
      },
      incomplete: {
        column: [],
        row: [],
        subgrid: []
      }
    }
  end

  def row(i)
    grid[i-1]
  end

  def column(i)
    grid.map { |row| row[i-1] }
  end

  # subgrid is laid out as below
  #           1-based                        0-based
  #       1       2       3              0       1       2     <- grid_column_index
  #     1 - 3   4 - 6   7 - 9          0 - 2   3 - 5   6 - 8
  #   1 . . . | . . . | . . .        0 . . . | . . . | . . .
  # 1 | . 1 . | . 2 . | . 3 .      0 | . 0 . | . 1 . | . 2 .
  #   3 . . . | . . . | . . .        2 . . . | . . . | . . .
  #     +-----+-------+-----+          +-----+-------+-----+
  #   4 . . . | . . . | . . .        3 . . . | . . . | . . .
  # 2 | . 4 . | . 5 . | . 6 .      1 | . 3 . | . 4 . | . 5 .
  #   6 . . . | . . . | . . .        5 . . . | . . . | . . .
  #     +-----+-------+-----+          +-----+-------+-----+
  #   7 . . . | . . . | . . .        6 . . . | . . . | . . .
  # 3 | . 7 . | . 8 . | . 9 .      2 | . 6 . | . 7 . | . 8 .
  #   9 . . . | . . . | . . .        8 . . . | . . . | . . .
  #
  #                                ^
  #                                grid_row_index
  #
  def subgrid(i)
    i = i - 1 # convert to 0-based

    grid_row_index = i / 3
    grid_column_index = i % 3

    row_range = grid_row_index * 3 ... grid_row_index.next * 3
    column_range = grid_column_index * 3 ... grid_column_index.next * 3

    subgrid_array = []
    row_range.each do |ri|
      column_range.each do |ci|
        subgrid_array << grid[ri][ci]
      end
    end
    subgrid_array
  end

  def validate!
    reset_errors!

    [:invalid, :incomplete].each do |error_type|
      [:row, :column, :subgrid].each do |array_type|
        (1..9).each do |i|
          if SudokuValidator.array_is? error_type, send(array_type, i)
            errors[error_type][array_type] << i 
          end
        end
      end
    end
  end

  def valid?
    [:row, :column, :subgrid].all? { |array_type| errors[:invalid][array_type].none? }
  end

  def complete?
    [:row, :column, :subgrid].all? { |array_type| errors[:incomplete][array_type].none? }
  end

  def reset_errors!
    [:invalid, :incomplete].each do |error_type|
      [:row, :column, :subgrid].each do |array_type| 
        errors[error_type][array_type].clear
      end
    end
  end

  def error_messages(type)
    errors[type].map do |key, vals| 
      "#{type} #{key}s: #{vals.join(", ")}" if vals.any? 
    end.compact.sort
  end
end