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

    describe "errors" do
      context "a valid puzzle" do
        specify "contains no errors" do
          puzzle = double(:valid? => true, :complete? => false)
          expect(Validator.new(puzzle).errors).to be_empty
        end
      end

      context "an invalid puzzle" do
        let(:puzzle) { double(:valid? => false, :complete? => false) }
        let(:errors) { Validator.new(puzzle).errors.map(&:to_s) }

        before(:each) do
          [:rows, :columns, :boxes].each do |message|
            allow(puzzle).to receive(message).and_return({})
          end
        end

        it "returns an error for a unit that contains a duplicate number" do
          puzzle.stub(:rows).and_return({ 1 => Row[1, 8, 2, 3, 4, 5, 6, 7, 8] })
          expect(errors).to include "Row 1 contains a duplicate 8 in squares 2 and 9"
        end

        it "ignores duplicate 0s as they are empty squares" do
          puzzle.stub(:columns).and_return({ 4 => Column[0, 1, 0, 2, 0, 3, 0, 4, 0] })
          expect(errors).to be_empty
        end

        it "returns errors for a unit that contains multiple duplicate numbers" do
          puzzle.stub(:boxes).and_return({ 7 => Box[2, 3, 1, 6, 2, 7, 3, 3, 0] })
          expect(errors).to include "Box 7 contains a duplicate 2 in squares 1 and 5"
          expect(errors).to include "Box 7 contains a duplicate 3 in squares 2, 7 and 8"
        end
      end
    end
  end
end
