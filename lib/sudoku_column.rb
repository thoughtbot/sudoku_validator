require 'matrix'

module Sudoku
  class Column
    def self.[](*values)
      new(Vector.elements(values))
    end

    def eql?(other)
      hash === other.hash
    end
    alias_method :==, :eql?

    def hash
      @column.hash
    end

    private

    def initialize(column)
      @column = column
    end
  end
end
