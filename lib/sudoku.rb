require 'matrix'

class Sudoku
  def initialize(file)
    @matrix = Matrix.rows(parse_rows_from_file(file))
  end

  def rows
    @matrix.row_vectors.map(&:to_a)
  end

  def columns
    @matrix.column_vectors.map(&:to_a)
  end

  def blocks
    [0, 3, 6].repeated_permutation(2).map { |x, y|
      @matrix.minor(x, 3, y, 3).to_a.flatten
    }
  end

  private
  def parse_rows_from_file(file)
    file.each_line.reject{ |line| line.include?('-') }.map { |line|
      numbers_row_from_line(line)
    }
  end

  def numbers_row_from_line(line)
    line.split(/ \||\s/).map { |value| value.to_i unless value == '.' }
  end
end
