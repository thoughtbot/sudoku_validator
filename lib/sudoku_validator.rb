module Sudoku
  class Validator
    attr_reader :puzzle

    def initialize(puzzle = nil)
      raise(ArgumentError, "A Puzzle is required.") if puzzle.nil?
      @puzzle = puzzle
    end

    def status
      case [puzzle.valid?, puzzle.complete?]
      when [true, true]  then "This sudoku is valid."
      when [true, false] then "This sudoku is valid, but incomplete."

      else "This sudoku is invalid."
      end
    end

    def errors

    end
  end
end
