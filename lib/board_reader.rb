module Sudoku
  class BoardReader

    def initialize(file)
      @file = file
    end

    def read
      board = []
      open(@file).each_with_index do |l,index|
        board << l.chomp!
        # could get more involved checking specific lines here like ---+---+---
        raise "Invalid board string [#{board[index]}]" if board[index].match(/^[1-9|+.\-\s]+$/) == nil
      end
      board
    end
  end
end