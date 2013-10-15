require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_reader.rb'

describe SudokuValidator do
  describe "#complete?" do
    context "when the sudoku is complete" do
      it "is true" do
        expect(validator).to be_complete
      end

      def reader
        SudokuReader.new('valid_complete.sudoku')
      end
    end

    context "when the sudoku is complete" do
      it "is true" do
        expect(validator).to_not be_complete
      end

      def reader
        SudokuReader.new('valid_incomplete.sudoku')
      end
    end
  end

  describe "#valid?" do
    context "when the sudoku is valid" do
      it "is true" do
        expect(validator).to be_valid
      end

      def reader
        SudokuReader.new('valid_complete.sudoku')
      end
    end

    context "when the sudoku is complete" do
      it "is true" do
        expect(validator).to_not be_valid
      end

      def reader
        SudokuReader.new('invalid_incomplete.sudoku')
      end
    end
  end

  def validator
    SudokuValidator.new(reader)
  end
end
