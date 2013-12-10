module Sudoku
  module Unit
    def positions
      squares.each.with_index(1).inject ({}) do |h, (number, position)|
        h[number] = h[number] ? [h[number]].flatten << position : position
        h
      end
    end

    def valid?
      non_empty_squares.uniq.count === non_empty_squares.count
    end

    def complete?
      squares.none? { |square| empty?(square) }
    end

    private

    def squares
      raise("Please set @squares in the object that implements this interface.") unless defined?(@squares)
      @squares
    end

    def non_empty_squares
      squares.reject { |square| empty?(square) }
    end

    def empty?(square)
      square === 0
    end
  end

  class BaseUnit
    include Unit

    def self.[](*values)
      new(values)
    end

    def initialize(values)
      @squares = values
    end

    def eql?(other)
      self.class == other.class && hash == other.hash
    end

    def hash
      squares.hash
    end

    alias_method :==, :eql?
  end

  class Row < BaseUnit
    def type
      "Row"
    end
  end

  class Column < BaseUnit
    def type
      "Column"
    end
  end

  class Box < BaseUnit
    def type
      "Box"
    end
  end
end
