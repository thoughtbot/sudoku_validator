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
        raise "Invalid board string [#{board[index]}]" if board[index].match(valid_chars) == nil
      end
      board
    end

    private
    def valid_chars
      /^[1-9|+.\-\s]+$/
    end
  end
end