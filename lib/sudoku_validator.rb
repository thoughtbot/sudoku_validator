class SudokuValidator

  attr_reader :grid
  attr_reader :errors

  def initialize(file_path)
    @grid = SudokuReader.reader_from_file(file_path).grid
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

  def valid_array?(array)
    numbers_only(array).uniq.length == numbers_only(array).length
  end

  def complete_array?(array)
    numbers_only(array).length == 9
  end

  def numbers_only(array)
    array.reject { |el| el == "." }
  end

  def array_is?(validation_type, array)
    if validation_type == :invalid
      not valid_array? array
    else
      not complete_array? array
    end
  end

  def row(i)
    grid[i-1]
  end

  def column(i)
    grid.map { |row| row[i-1] }
  end

  # subgrid is laid out as below
  #           1-based                        0-based
  #       1       2       3              0       1       2     <- grid_index for column
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
  #                                grid_index for row
  #
  def subgrid(i)
    grid[row_starts_for_grid(i), 3].map do |row| 
      row[column_starts_for_grid(i), 3]
    end.flatten
  end

  def row_starts_for_grid(i)
    zero_based(i) / 3 * 3
  end

  def column_starts_for_grid(i)
    zero_based(i) % 3 * 3
  end

  def zero_based(i)
    i - 1
  end

  def validate!
    reset_errors!
    [:invalid, :incomplete].each do |error_type|
      [:row, :column, :subgrid].each do |array_type|
        (1..9).each do |i|          
          errors[error_type][array_type] << i if array_is? error_type, send(array_type, i)
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