require 'sudoku_puzzle'

describe Sudoku::Puzzle do
  it "throws an ArgumentError if not passed an array of rows" do
    expect { Sudoku::Puzzle.new }.to raise_error(ArgumentError)
  end

  it "is a value object (two puzzles with the same numbers are equal)" do
    p1 = Sudoku::Puzzle.new(input_rows)
    p2 = Sudoku::Puzzle.new(input_rows)

    expect(p1).to eq p2
  end

  describe ":rows" do
    it "returns an array of Row objects" do
      puzzle = Sudoku::Puzzle.new(input_rows)

      expect(puzzle.rows.count).to eq 9
      expect(puzzle.rows.first).to eq Sudoku::Row[0, 5, 9, 6, 1, 2, 4, 3, 0]
      expect(puzzle.rows.last).to eq Sudoku::Row[0, 9, 8, 7, 3, 6, 2, 4, 0]
    end
  end

  describe ":columns" do
    it "returns an array of Column objects" do
      puzzle = Sudoku::Puzzle.new(input_rows)

      expect(puzzle.columns.count).to eq 9
      expect(puzzle.columns.first).to eq Sudoku::Column[0, 7, 1, 9, 3, 2, 4, 6, 0]
      expect(puzzle.columns.last).to eq Sudoku::Column[0, 9, 8, 2, 4, 6, 5, 3, 0]
    end
  end

  describe ":boxes" do
    it "returns an array of Box objects" do
      puzzle = Sudoku::Puzzle.new(input_rows)

      expect(puzzle.boxes.count).to eq 9
      expect(puzzle.boxes.first).to eq Sudoku::Box[0, 5, 9, 7, 0, 3, 1, 6, 0]
    end
  end

  describe "completeness" do
    specify "a puzzle is complete if all of its rows are complete" do
      puzzle = Sudoku::Puzzle.new([[1, 2, 3], [4, 9, 8], [5, 7, 6]])
      expect(puzzle).to be_complete
    end

    specify "a puzzle is incomplete if any of its rows are incomplete" do
      puzzle = Sudoku::Puzzle.new(input_rows)
      expect(puzzle).not_to be_complete
    end
  end

  def input_rows
    [
      [0, 5, 9, 6, 1, 2, 4, 3, 0],
      [7, 0, 3, 8, 5, 4, 1, 0, 9],
      [1, 6, 0, 3, 7, 9, 0, 2, 8],
      [9, 8, 6, 0, 4, 0, 3, 5, 2],
      [3, 7, 5, 2, 0, 8, 9, 1, 4],
      [2, 4, 1, 0, 9, 0, 7, 8, 6],
      [4, 3, 0, 9, 8, 1, 0, 7, 5],
      [6, 0, 7, 4, 2, 5, 8, 0, 3],
      [0, 9, 8, 7, 3, 6, 2, 4, 0]
    ]
  end
end
