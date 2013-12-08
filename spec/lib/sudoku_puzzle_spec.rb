require 'sudoku_puzzle'

module Sudoku
  describe Puzzle do
    it "throws an ArgumentError if not passed an array of rows" do
      expect { Puzzle.new }.to raise_error(ArgumentError)
    end

    it "is a value object (two puzzles with the same numbers are equal)" do
      p1 = Puzzle.new(input_rows)
      p2 = Puzzle.new(input_rows)

      expect(p1).to eq p2
    end

    describe ":rows" do
      it "returns an array of Row objects" do
        puzzle = Puzzle.new(input_rows)

        expect(puzzle.rows.count).to eq 9
        expect(puzzle.rows.first).to eq Row[0, 5, 9, 6, 1, 2, 4, 3, 0]
        expect(puzzle.rows.last).to eq Row[0, 9, 8, 7, 3, 6, 2, 4, 0]
      end
    end

    describe ":columns" do
      it "returns an array of Column objects" do
        puzzle = Puzzle.new(input_rows)

        expect(puzzle.columns.count).to eq 9
        expect(puzzle.columns.first).to eq Column[0, 7, 1, 9, 3, 2, 4, 6, 0]
        expect(puzzle.columns.last).to eq Column[0, 9, 8, 2, 4, 6, 5, 3, 0]
      end
    end

    describe ":boxes" do
      it "returns an array of Box objects" do
        puzzle = Puzzle.new(input_rows)

        expect(puzzle.boxes.count).to eq 9
        expect(puzzle.boxes.first).to eq Box[0, 5, 9, 7, 0, 3, 1, 6, 0]
      end
    end

    describe "completeness" do
      specify "a puzzle is complete if all of its rows are complete" do
        puzzle = Puzzle.new([[1, 2, 3], [4, 9, 8], [5, 7, 6]])
        expect(puzzle).to be_complete
      end

      specify "a puzzle is incomplete if any of its rows are incomplete" do
        puzzle = Puzzle.new(input_rows)
        expect(puzzle).not_to be_complete
      end
    end

    describe "validity" do
      specify "a puzzle is invalid if any of its rows, columns or boxes are invalid" do
        puzzle = Puzzle.new(input_rows)
        expect(puzzle).not_to be_valid
      end

      specify "a puzzle is valid if all of its rows, columns and boxes are valid" do
        puzzle = Puzzle.new(valid_incomplete)
        expect(puzzle).to be_valid
      end
    end

    def input_rows
      [
        [0, 5, 9, 6, 1, 2, 4, 3, 0],
        [7, 0, 3, 8, 5, 1, 1, 0, 9],
        [1, 6, 0, 3, 7, 9, 0, 2, 8],
        [9, 8, 6, 0, 4, 0, 3, 5, 2],
        [3, 7, 5, 2, 0, 8, 9, 1, 4],
        [2, 4, 1, 0, 9, 0, 7, 8, 6],
        [4, 3, 0, 9, 8, 1, 0, 7, 5],
        [6, 0, 7, 4, 2, 5, 8, 0, 3],
        [0, 9, 8, 7, 3, 6, 2, 4, 0]
      ]
    end

    def valid_incomplete
      [
        [8, 5, 0, 0, 0, 2, 4, 0, 0],
        [7, 2, 0, 0, 0, 0, 0, 0, 9],
        [0, 0, 4, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 7, 0, 0, 2],
        [3, 0, 5, 0, 0, 0, 9, 0, 0],
        [0, 4, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 8, 0, 0, 7, 0],
        [0, 1, 7, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 3, 6, 0, 4, 0]
      ]
    end
  end
end
