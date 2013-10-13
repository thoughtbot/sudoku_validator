require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_board'

describe SudokuValidator do
  before do
    
  end
  describe SudokuBoard do

    before do
      @game = SudokuBoard.new("valid_complete.sudoku")
    end
    it "reads the first character of the sudoku file" do
      expect(@game[1,1]).to eql 8
    end
    it "reads the first row of the sudoku file" do
      expect(@game.row(1)).to eql [8,5,9,6,1,2,4,3,7]
    end
    it "reads the first column of the sudoku file" do
      expect(@game.col(1)).to eql [8,7,1,9,3,2,4,6,5]
    end
  
  end

end
