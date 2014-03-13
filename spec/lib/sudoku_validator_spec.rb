require 'spec_helper'

describe SudokuValidator do
  describe "normalizing input" do
    it "converts lines arrays of integers" do
      input = "8 | ,\n 7 8\n"
      validator = described_class.new(input)
      expected = %w[8 7 8]
      expect(validator.to_a).to eq expected
    end

    it "assigns nil to empty squares" do
      input = "1 | . | . | ."
      validator = described_class.new(input)
      expected = %w[1 . . .]
      expect(validator.to_a).to eq expected
    end
  end

  describe "#valid?" do
    it "recognizes a single number as valid" do
      single = described_class.new "7"
      expect(single.valid?).to be
    end

    it "recognizes duplicate in subgrid as invalid" do
      grid = %w[
        1 2 3 4
        5 6 7 8
        9 4 2 3
        4 5 6 7
      ]
      duplicates = described_class.new(grid)
      expect(duplicates.valid?).to be_false
    end

    it "handles nil properly" do
      grid = %w[
        1 2 3 4
        5 6 7 8
        9 . 2 .
        4 5 6 7
      ]
      nils = described_class.new(grid)
      expect(nils.valid?).to be
    end
  end

  describe "#complete?" do
    it "identifies complete grids" do
      grid = %w[
        1 2 3 4
        5 6 7 8
        9 4 2 3
        4 5 6 7
      ]
      validator = described_class.new(grid)
      expect(validator.complete?).to be_true
    end
  end
end

def load_sudoku(name)
  File.open("spec/fixtures/#{name}.sudoku") do |f|
    f.read
  end
end
