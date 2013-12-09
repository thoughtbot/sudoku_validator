require_relative 'sudoku_unit'
require 'matrix'

module Sudoku
  class Puzzle
    def initialize(rows = [])
      raise(ArgumentError, "An array of rows is required to create a puzzle.") if rows.empty?
      @grid = create_grid(rows)
    end

    def rows
      Hash[@grid.row_vectors.map.with_index(1) do |row, index|
        [index, Row[*row]]
      end]
    end

    def columns
      Hash[@grid.column_vectors.map.with_index(1) do |column, index|
        [index, Column[*column]]
      end]
    end

    def boxes
      Hash[[0, 3, 6].repeated_permutation(2).map.with_index(1) do |(x, y), index|
        [index, Box[*@grid.minor(x, 3,  y, 3).to_a.flatten]]
      end]
    end

    def complete?
      rows.any? { |index, row| row.complete? }
    end

    def valid?
      all_units.all? { |unit| unit.valid? }
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

    def all_units
      [:rows, :columns, :boxes].map do |message|
        send(message).map {|index, unit| unit}
      end.flatten
    end
  end
end
