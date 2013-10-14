require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_board'

describe SudokuValidator do
  before do

  end
  describe "valid games" do
    it "correctly recognizes a valid, complete game" do
      result = %x{"./sudoku_validator" "./valid_complete.sudoku"}
      expect(result).to eq "This sudoku is valid, and complete.\n"
    end
    it "recognizes a valid, incomplete game" do
      result = `./sudoku_validator ./valid_incomplete.sudoku`
      expect(result).to eq "This sudoku is valid, and incomplete.\n"
    end
  end
  describe "invalid games" do
    it "recognizes an invalid, complete game" do
      result = `./sudoku_validator ./invalid_complete.sudoku`
      expect(result).to eq "This sudoku is invalid, and complete.\n"
    end
  end
end
describe SudokuBoard do
  describe "complete games" do
    before do
      @game = SudokuBoard.new("valid_complete.sudoku")
    end
    it "returns the first character of the sudoku file" do
      expect(@game[1,1]).to eql 8
    end
    it "returns an arbitrary element from the board" do
      expect(@game[4,5]).to eql 4
    end
    it "returns the first row of the sudoku file" do
      expect(@game.row(1)).to eql [8,5,9,6,1,2,4,3,7]
    end
    it "returns the first column of the sudoku file" do
      expect(@game.col(1)).to eql [8,7,1,9,3,2,4,6,5]
    end
    it "returns a 3x3 sub-grid as an array" do
      expect(@game.sub_grid(1)).to eql [8,5,9,7,2,3,1,6,4]
    end
    it "returns a middle 3x3 sub-grid" do
      expect(@game.sub_grid(5)).to eql [1,4,7,2,6,8,5,9,3]
    end
    it "successfully returns the last sub-grid" do
     expect(@game.sub_grid(9)).to eql [6,7,5,8,9,3,2,4,1] 
    end
  end
  describe "incomplete games" do
    before do
      @game = SudokuBoard.new("invalid_incomplete.sudoku")
    end
    it "returns zero for an empty position" do
      expect(@game[2,4]).to eql 0 
    end
    it "returns the expected row" do
      expect(@game.row(4)).to eql [0,0,0,1,0,7,0,0,2]
    end
    it "returns the expected column" do
      expect(@game.col(8)).to eql [0,0,0,0,0,0,7,0,4]
    end
    it "returns the expected sub-grid" do
      expect(@game.sub_grid(8)).to eql [0,8,0,0,0,0,0,3,6]
    end
  end
end
