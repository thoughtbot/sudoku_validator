require_relative '../lib/sudoku_reader'

describe SudokuReader do
  describe "#lines" do
    it "give lines" do
      reader = SudokuReader.new('valid_complete.sudoku')
      expect(reader.lines[0]).to eq [8,5,9,6,1,2,4,3,7]
    end

    it "convert invalid values by 0" do
      reader = SudokuReader.new('valid_incomplete.sudoku')
      expect(reader.lines[0]).to eq [8,5,0,0,0,2,4,0,0]
    end
  end

  describe "#columns" do
    it "give columns" do
      reader = SudokuReader.new('valid_complete.sudoku')
      expect(reader.columns[0]).to eq [8,7,1,9,3,2,4,6,5]
    end

    it "convert invalid values by 0" do
      reader = SudokuReader.new('valid_incomplete.sudoku')
      expect(reader.columns[0]).to eq [8,7,0,0,3,0,0,0,0]
    end
  end

  describe "#blocks" do
    it "give blocks" do
      reader = SudokuReader.new('valid_complete.sudoku')
      expect(reader.blocks[0]).to eq [8,5,9,7,2,3,1,6,4]
    end

    it "convert invalid values by 0" do
      reader = SudokuReader.new('valid_incomplete.sudoku')
      expect(reader.blocks[0]).to eq [8,5,0,7,2,0,0,0,4]
    end
  end
end
