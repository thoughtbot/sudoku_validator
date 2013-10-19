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

  def validate!
    [:invalid, :incomplete].each do |error_type|
      reset_errors(error_type)
      [:row, :column, :subgrid].each do |row_or_column_or_subgrid|
        (1..9).each do |i|
          row_or_column_or_subgrid_array = send(row_or_column_or_subgrid, i) 

          validation_method = (error_type.to_s.gsub(/in/, '')+'_array?').to_sym # :invalid -> :valid_array?

          unless SudokuValidator.send validation_method, row_or_column_or_subgrid_array
            @errors[error_type][row_or_column_or_subgrid] << i 
          end
        end
      end
    end
  end

  def valid?
    errors[:invalid][:row].length == 0 and 
    errors[:invalid][:column].length == 0 and 
    errors[:invalid][:subgrid].length == 0
  end

  def complete?
    errors[:incomplete][:row].length == 0 and 
    errors[:incomplete][:column].length == 0 and 
    errors[:incomplete][:subgrid].length == 0
  end

  def reset_errors(type)
    @errors[type][:row].clear
    @errors[type][:column].clear
    @errors[type][:subgrid].clear
  end

end