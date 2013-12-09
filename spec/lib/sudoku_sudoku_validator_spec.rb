require 'sudoku_validator'
require 'sudoku_unit'

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

    describe "errors" do
      context "a valid puzzle" do
        specify "contains no errors" do
          puzzle = double(:valid? => true, :complete? => false)
          allow(puzzle).to receive(:rows).and_return({})
          expect(Validator.new(puzzle).errors).to be_empty
        end
      end

      context "an invalid puzzle" do
        context "with a row duplicate" do
          it "contains a detailed error" do
            puzzle = double(:valid? => false, :complete? => true,
                            :rows => {
                              1 => Row[1, 8, 2, 3, 4, 5, 7, 7, 8],
                              2 => Row[1, 2, 3, 4, 5, 6, 7, 8, 9],
                              9 => Row[1, 8, 8, 3, 4, 5, 6, 7, 8]
                            })

            errors = Validator.new(puzzle).errors
            expect(errors).to include "Row 1 contains a duplicate 8 in squares 2 and 9"
            expect(errors).to include "Row 9 contains a duplicate 8 in squares 2, 3 and 9"
          end
        end
      end
    end
  end
end
