require 'matrix'

module Sudoku
  class Row
    def self.[](*values)
      new(Vector.elements(values))
    end

    def positions
      to_a.each.with_index(1).inject ({}) do |h, (number, position)|
        h[number] = h[number] ? [h[number]].flatten << position : position
        h
      end
    end

    def to_a
      @row.to_a
    end

    def complete?
      to_a.reject {|n| n === 0}.uniq.length === to_a.length
    end

    def eql?(other)
      hash === other.hash
    end
    alias_method :==, :eql?

    def hash
      @row.hash
    end

    private

    def initialize(row)
      @row = row
    end
  end
end
