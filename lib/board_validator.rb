module Sudoku
  class BoardValidator

    def initialize( board_string )
      raise 'Invalid number of rows in board' if board_string.count != 11

      row_index = 0  # can't use _with_index because of line rows
      board_string.each do |one_row|
        one_row_number_array = one_row.gsub('|','').gsub('+','').gsub('-','').split
        if one_row_number_array.count == 9
          init_one_row( row_index, one_row_number_array )
          row_index += 1
        else
          raise 'Invalid Board' if one_row_number_array.count != 0
        end
      end
    end

    def valid_board?
      @rows.each {|row| return false if !array_unique?(row)}
      @cols.each {|col| return false if !array_unique?(col)}
      @grids.each {|grid| return false if !array_unique?(grid)}
      true
    end





    private

    def init_one_row( row_id, row_string )
      # store the row as a row
      rows[row_id].concat(row_string)
      # store each element of the array into the cols arrays
      row_string.each_with_index {|x,i| cols[i] << x}
      # pull off 3 at a top and store in the grids array
      in_groups_of(row_string,3).each_with_index do |triplet,i|
        grids[((row_id/3)*3)+i].concat(triplet)
      end
    end

    def array_unique?(arr)
      # clone the tested array because delete is destructive
      _arr = arr.clone
      _arr.delete('.')
      _arr.uniq.count == _arr.count
    end

    def rows
      @rows ||= [[],[],[],[],[],[],[],[],[]]
    end

    def cols
      @cols ||= [[],[],[],[],[],[],[],[],[]]
    end

    def grids
      @grids ||= [[],[],[],[],[],[],[],[],[]]
    end

    def in_groups_of(array,number)
      groups = []
      array.each_slice(number) {|group| groups << group}
      groups
    end
  end
end