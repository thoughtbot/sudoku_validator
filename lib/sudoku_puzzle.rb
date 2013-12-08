require_relative 'sudoku_unit'
require 'matrix'

module Sudoku
  class Puzzle
    def initialize(rows = [])
      raise(ArgumentError, "An array of rows is required to create a puzzle.") if rows.empty?
      @grid = create_grid(rows)
    end

    def rows
      @grid.row_vectors.map do |row|
        Sudoku::Row[*row]
      end
    end

    def columns
      @grid.column_vectors.map do |column|
        Sudoku::Column[*column]
      end
    end

    def boxes
      [0, 3, 6].repeated_permutation(2).map do |x, y|
        Sudoku::Box[*@grid.minor(x, 3,  y, 3).to_a.flatten]
      end
    end

    def complete?
      rows.any? { |row| row.complete? }
    end

    def eql?(other)
      hash == other.hash
    end

    def hash
      @grid.hash
    end

    alias_method :==, :eql?

    private

    def create_grid(input_rows)
      Matrix[*input_rows]
    end
  end
end
