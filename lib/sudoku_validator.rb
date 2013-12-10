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

      [:rows, :columns, :boxes].map do |message|
        puzzle.send(message).map do |index, unit|
          duplicates(unit).map do |number, positions|
            DuplicateError.new(unit.type, index, number, positions)
          end
        end
      end.flatten
    end

    private

    def duplicates(unit)
      unit.positions.select do |number, position|
        non_empty?(number) && duplicate?(position)
      end
    end

    def non_empty?(number)
      number != 0
    end

    def duplicate?(position)
      position.is_a?(Array)
    end
  end

  class DuplicateError < Struct.new(:type, :index, :number, :positions)
    def to_s
      "#{type} #{index} contains a duplicate #{number} in squares #{list(positions)}"
    end

    private

    def list(positions)
      "#{positions[0...-1].join(', ')} and #{positions.last}"
    end
  end
end
