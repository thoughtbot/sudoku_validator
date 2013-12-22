module Sudoku
  class Unit
    def self.[](*values)
      new(values)
    end

    def initialize(values)
      @squares = values
    end

    def positions
      @squares.each.with_index(1).inject ({}) do |h, (number, position)|
        h.tap { |h| h[number] = h[number] ? [h[number]].flatten << position : position }
      end
    end

    def valid?
      non_empty_squares.uniq.count === non_empty_squares.count
    end

    def complete?
      @squares.none?(&:zero?)
    end

    def eql?(other)
      self.class == other.class && hash == other.hash
    end

    def hash
      @squares.hash
    end

    alias_method :==, :eql?

    private

    def non_empty_squares
      @squares.reject(&:zero?)
    end
  end

  class Row < Unit
    def type
      "Row"
    end
  end

  class Column < Unit
    def type
      "Column"
    end
  end

  class Box < Unit
    def type
      "Box"
    end
  end
end
