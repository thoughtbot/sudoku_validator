require 'sudoku_validator'

module Sudoku
  describe Validator do
    it "throws an ArgumentError if a puzzle is not passed in" do
      expect { Validator.new }.to raise_error(ArgumentError)
    end

    describe "status" do
      it "returns 'This sudoku is valid.' if the puzzle is valid and complete" do
        puzzle = double(:valid? => true, :complete? => true)
        expect(Validator.new(puzzle).status).to eq "This sudoku is valid."
      end

      it "returns 'This sudoku is valid, but incomplete.' if the puzzle is valid, but incomplete" do
        puzzle = double(:valid? => true, :complete? => false)
        expect(Validator.new(puzzle).status).to eq "This sudoku is valid, but incomplete."
      end

      it "returns 'This sudoku is invalid.' if the puzzle is invalid, but complete." do
        puzzle = double(:valid? => false, :complete? => true)
        expect(Validator.new(puzzle).status).to eq "This sudoku is invalid."
      end

      it "returns 'This sudoku is invalid.' if the puzzle is invalid and incomplete." do
        puzzle = double(:valid? => false, :complete? => false)
        expect(Validator.new(puzzle).status).to eq "This sudoku is invalid."
      end
    end

    it "responds to :errors" do
      expect(Validator.new(double())).to respond_to(:errors)
    end
  end
end
