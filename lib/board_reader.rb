module Sudoku
  class BoardReader

    def initialize(file)
      @file = file
    end

    def read
      board = []
      open(@file).each do |line|
        board << line.chomp
        # could get more involved checking specific lines here
        raise 'Invalid board string' unless line =~ /[1-9].+-|/
      end
      board
    end
  end
end