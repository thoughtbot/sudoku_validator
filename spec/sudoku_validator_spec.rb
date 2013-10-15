require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_reader.rb'

describe SudokuValidator do
  describe "#complete?" do
    context "when the sudoku is complete" do
      it "is true" do
        reader = SudokuReader.new('valid_complete.sudoku')
        validator = SudokuValidator.new(reader)
        expect(validator).to be_complete
      end
    end

    context "when the sudoku is complete" do
      it "is true" do
        reader = SudokuReader.new('valid_incomplete.sudoku')
        validator = SudokuValidator.new(reader)
        expect(validator).to_not be_complete
      end
    end
  end
end
