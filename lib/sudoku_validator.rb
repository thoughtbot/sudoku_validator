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
      return [] if puzzle.valid?
      puzzle.rows.map do |row_number, row|
        x = row.positions.select { |value, position| position.is_a?(Array) }
        x.empty? ? nil : x.map {|number, squares| DuplicateError.new(row_number, number, squares).to_s }
      end.compact.flatten
    end

    class DuplicateError < Struct.new(:row_number, :number, :squares)
      def to_s
        "#{unit_type} #{row_number} contains a duplicate #{number} in squares #{list(squares)}"
      end

      private

      def unit_type
        "Row"
      end

      def list(squares)
        "#{squares.first(squares.count-1).join(', ')} and #{squares.last}"
      end
    end
  end
end
