require_relative '../../lib/sudoku'

class AssessSudokuCompleteness; end

describe Sudoku do
  describe "#rows" do
    it "returns the rows" do
      sudoku = Sudoku.new(File.open('valid_complete.sudoku'))
      expect(sudoku.rows).to eq([
        [8,5,9,6,1,2,4,3,7],
        [7,2,3,8,5,4,1,6,9],
        [1,6,4,3,7,9,5,2,8],
        [9,8,6,1,4,7,3,5,2],
        [3,7,5,2,6,8,9,1,4],
        [2,4,1,5,9,3,7,8,6],
        [4,3,2,9,8,1,6,7,5],
        [6,1,7,4,2,5,8,9,3],
        [5,9,8,7,3,6,2,4,1]
      ])
    end

    it "replaces uses nil for blank values" do
      sudoku = Sudoku.new(File.open('valid_incomplete.sudoku'))
      expect(sudoku.rows).to eq([
        [8,5,nil,nil,nil,2,4,nil,nil],
        [7,2,nil,nil,nil,nil,nil,nil,9],
        [nil,nil,4,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,1,nil,7,nil,nil,2],
        [3,nil,5,nil,nil,nil,9,nil,nil],
        [nil,4,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,8,nil,nil,7,nil],
        [nil,1,7,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,3,6,nil,4,nil]
      ])
    end
  end

  describe "#columns" do
    it "returns the columns" do
      sudoku = Sudoku.new(File.open('valid_complete.sudoku'))
      expect(sudoku.columns).to eq([
        [8,7,1,9,3,2,4,6,5],
        [5,2,6,8,7,4,3,1,9],
        [9,3,4,6,5,1,2,7,8],
        [6,8,3,1,2,5,9,4,7],
        [1,5,7,4,6,9,8,2,3],
        [2,4,9,7,8,3,1,5,6],
        [4,1,5,3,9,7,6,8,2],
        [3,6,2,5,1,8,7,9,4],
        [7,9,8,2,4,6,5,3,1]
      ])
    end
  end

  describe "#blocks" do
    it "returns the blocks" do
      sudoku = Sudoku.new(File.open('valid_complete.sudoku'))
      expect(sudoku.blocks).to eq([
        [8,5,9,7,2,3,1,6,4],
        [6,1,2,8,5,4,3,7,9],
        [4,3,7,1,6,9,5,2,8],
        [9,8,6,3,7,5,2,4,1],
        [1,4,7,2,6,8,5,9,3],
        [3,5,2,9,1,4,7,8,6],
        [4,3,2,6,1,7,5,9,8],
        [9,8,1,4,2,5,7,3,6],
        [6,7,5,8,9,3,2,4,1]
      ])
    end
  end
end
