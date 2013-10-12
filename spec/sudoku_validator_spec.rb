require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_board'

describe SudokuValidator do
  before do
    
  end
  describe SudokuBoard do

    before do
      
    end
    it "reads the first character of the sudoku file" do
      board = SudokuBoard.new ("../valid_complete.sudoku")
      expect(board[1,1]).to eql 8
    end
  
  end

end
