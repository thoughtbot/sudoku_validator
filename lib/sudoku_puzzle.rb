require_relative 'sudoku_row'
require_relative 'sudoku_column'

module Sudoku
  class Puzzle
    def initialize(rows = [])
      raise(ArgumentError, "An array of rows is required to create a puzzle.") if rows.empty?
      @grid = create_grid(rows)
    end

    def rows
      @grid.row_vectors.map { |row| Sudoku::Row[*row] }
    end

    def columns
      @grid.column_vectors.map { |column| Sudoku::Column[*column] }
    end

    def eql?(other)
      hash == other.hash
    end
    alias_method :==, :eql?

    def hash
      @grid.hash
    end

    private

    def create_grid(input_rows)
      Matrix[*input_rows]
    end
  end
end
