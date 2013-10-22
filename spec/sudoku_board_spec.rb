require_relative '../lib/sudoku_board'

describe SudokuBoard do
  before do
    @game_vc = SudokuBoard.new("valid_complete.sudoku")
    @game_ii = SudokuBoard.new("invalid_incomplete.sudoku")
  end

  describe "#[]" do
    it "returns the first character of the sudoku file" do
      expect(@game_vc[1,1]).to eql 8
    end

    it "returns an arbitrary element from the board" do
      expect(@game_vc[4,5]).to eql 4
    end
    
    it "returns zero for an empty position" do
      expect(@game_ii[2,4]).to eql 0 
    end
  end

  describe "#row" do
    it "returns the first row of the sudoku file" do
      expect(@game_vc.row(1)).to eql [8,5,9,6,1,2,4,3,7]
    end
    
    it "returns the expected row" do
      expect(@game_ii.row(4)).to eql [0,0,0,1,0,7,0,0,2]
    end
  end

  describe "#col" do
    it "returns the first column of the sudoku file" do
      expect(@game_vc.col(1)).to eql [8,7,1,9,3,2,4,6,5]
    end
    
    it "returns the expected column" do
      expect(@game_ii.col(8)).to eql [0,0,0,0,0,0,7,0,4]
    end
  end

  describe "#sub_grid" do
    it "returns a 3x3 sub-grid as an array" do
      expect(@game_vc.sub_grid(1)).to eql [8,5,9,7,2,3,1,6,4]
    end

    it "returns a middle 3x3 sub-grid" do
      expect(@game_vc.sub_grid(5)).to eql [1,4,7,2,6,8,5,9,3]
    end

    it "successfully returns the last sub-grid" do
     expect(@game_vc.sub_grid(9)).to eql [6,7,5,8,9,3,2,4,1] 
    end

    it "successfully returns the first sub-grid" do
      expect(@game_vc.sub_grid(1)).to eql [8,5,9,7,2,3,1,6,4]
    end

    it "returns the expected sub-grid" do
      expect(@game_ii.sub_grid(8)).to eql [0,8,0,0,0,0,0,3,6]
    end
  end
end
