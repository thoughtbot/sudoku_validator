require_relative 'sudoku_row'

module Sudoku
  class Puzzle
    def initialize(rows = [])
      raise(ArgumentError, "An array of rows is required to create a puzzle.") if rows.empty?
      @rows = rows
    end

    def rows
      @rows.dup.map do |row|
        Sudoku::Row[*row]
      end
    end

    def eql?(other)
      hash == other.hash
    end
    alias_method :==, :eql?

    def hash
      @rows.hash
    end
  end
end
