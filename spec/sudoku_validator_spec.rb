require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_board'

describe SudokuValidator do

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
      expect(result).to include "This sudoku is invalid, and complete.\n"
      expect(result).to include "2 is repeated in col 6"
    end
  end

  describe "error handling" do
    before do
      @game = SudokuValidator.new "./invalid_complete.sudoku"
      @element = [1,2,3,2,5,6,7,8,9]
    end

    it "identifies correct element in #identify_errors" do
      expect(@game.identify_errors @element).to eql [2]
    end

    it "returns errors in #valid?" do
      expect(@game.valid?(@element)).to eq [false, [2]]
    end

    it "returns empty error array in #vaid? if no errors" do
      @element[3]=4
      expect(@game.valid?(@element)).to eq [true, []]
    end

    it "returns the descriptive error string for col errors" do
      @game.validate
      @game.errors.should include "2 is repeated in col 6"
    end

    it "returns the descriptive error string for row errors" do
      @game.board.board[0][0] = 7
      @game.validate
      @game.errors.should include "7 is repeated in row 1"
    end

    it "returns the descrptive error string for sub-grid errors" do
      @game.board.board[0][0] = 7
      @game.validate
      @game.errors.should include "7 is repeated in sub_grid 1"
    end

    it "ignores missing (zero) elements for incomplete sudokus" do
      @game.board.board[0][0] = 0 
      @game.board.board[0][6] = 0
      @game.board.board[0][3] = 0
      @game.validate
      @game.errors.should_not include "0 is repeated in row 1"
    end
  end
end
