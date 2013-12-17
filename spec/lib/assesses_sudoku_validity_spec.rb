require_relative '../../lib/assesses_sudoku_validity'

describe AssessesSudokuValidity do
  let(:sudoku) { double('sudoku') }
  subject { AssessesSudokuValidity.new(sudoku) }

  describe "#is_valid?" do
    it "returns true for valid sudokus" do
      expect(sudoku).to receive(:rows).and_return([
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
      expect(sudoku).to receive(:columns).and_return([
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
      expect(sudoku).to receive(:blocks).and_return([
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
      expect(subject.is_valid?).to be_true
    end

    it "returns false for invalid rows" do
      expect(sudoku).to receive(:rows).and_return([
          [1,5,9,6,1,2,4,3,7],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
        ])
      allow(sudoku).to receive(:columns)
      allow(sudoku).to receive(:blocks)
      expect(subject.is_valid?).to be_false
    end

    it "returns false for invalid columns" do
      expect(sudoku).to receive(:rows).and_return([
          [8,5,9,6,1,2,4,3,7],
          [8,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
        ])
      expect(sudoku).to receive(:columns).and_return([
          [8,8,nil,nil,nil,nil,nil,nil,nil],
          [5,nil,nil,nil,nil,nil,nil,nil,nil],
          [9,nil,nil,nil,nil,nil,nil,nil,nil],
          [6,nil,nil,nil,nil,nil,nil,nil,nil],
          [1,nil,nil,nil,nil,nil,nil,nil,nil],
          [2,nil,nil,nil,nil,nil,nil,nil,nil],
          [3,nil,nil,nil,nil,nil,nil,nil,nil],
          [7,nil,nil,nil,nil,nil,nil,nil,nil]
      ])
      allow(sudoku).to receive(:blocks)
      expect(subject.is_valid?).to be_false
    end

    it "returns false for invalid blocks" do
      expect(sudoku).to receive(:rows).and_return([
          [8,5,9,nil,nil,nil,nil,nil,nil],
          [6,8,2,nil,nil,nil,nil,nil,nil],
          [4,3,7,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
        ])
      expect(sudoku).to receive(:columns).and_return([
          [8,6,4,nil,nil,nil,nil,nil,nil],
          [5,8,3,nil,nil,nil,nil,nil,nil],
          [9,2,7,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
      ])
      expect(sudoku).to receive(:blocks).and_return([
          [8,5,9,6,8,2,4,3,7],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
        ])
      expect(subject.is_valid?).to be_false
    end
  end

  describe "#errors" do
    it "returns a list of errors and their locations" do
      expect(sudoku).to receive(:rows).and_return([
          [8,5,9,nil,nil,nil,nil,nil,nil],
          [6,8,2,nil,nil,nil,nil,nil,nil],
          [4,7,7,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
        ])
      expect(sudoku).to receive(:columns).and_return([
          [8,6,4,nil,nil,nil,nil,nil,nil],
          [5,8,7,nil,nil,nil,nil,nil,nil],
          [9,2,7,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
      ])
      expect(sudoku).to receive(:blocks).and_return([
          [8,5,9,6,8,2,4,7,7],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,nil,nil]
        ])
      expect(subject.errors).to eq({
        :rows => { 3 => [7] },
        :columns => {},
        :blocks => { 1 => [8, 7] }
      })
    end
  end
end
