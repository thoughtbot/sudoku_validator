module Sudoku

  class Columnizer
    attr_accessor :columns
    def initialize matrix
      @matrix = matrix
      @columns = []
    end

    def convert
      initialize_new_columns_matrix
      map_rows_to_columns
      @columns
    end

    def map_rows_to_columns
      @matrix.map {|row| map_row(row)}
    end

    def map_row(row)
      row.each_with_index {|item, index| push_column(index, item) }
    end

    def push_column(index,item)
      @columns[index] << item
    end

    private

    def initialize_new_columns_matrix
      @matrix.count.times {@columns << []}
    end
  end

end
