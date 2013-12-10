require 'sudoku_unit'

shared_examples "a Unit" do |type|
  context "completeness" do
    specify "a unit is incomplete if it contains empty squares" do
      expect(described_class[0, 5, 9, 6, 1, 2, 4, 3, 8]).not_to be_complete
    end

    specify "a unit is complete if all squares are filled in" do
      expect(described_class[7, 5, 9, 6, 1, 2, 4, 3, 8]).to be_complete
    end
  end

  context "validity" do
    specify "a unit is invalid if it contains duplicates (excludes empty squares)" do
      expect(described_class[0, 0, 9, 6, 1, 0, 9, 3, 8]).not_to be_valid
    end

    specify "a unit is valid if it contains no duplicates" do
      expect(described_class[0, 0, 2, 6, 1, 0, 9, 3, 8]).to be_valid
    end
  end

  describe "listing square values against their positions in the unit" do
    specify ":positions can list empty squares" do
      output = {
        0 => 8, 1 => 5, 2 => 6,
        4 => 7, 5 => 2, 6 => 4,
        7 => 1, 8 => 9, 9 => 3
      }
      expect(described_class[7, 5, 9, 6, 1, 2, 4, 0, 8].positions).to eq output
    end

    specify ":positions can list duplicate squares as an array" do
      output = {
        0 => [6, 8], 1 => 5, 4 => 7, 5 => 2,
        7 => [1, 4], 8 => 9, 9 => 3
      }
      expect(described_class[7, 5, 9, 7, 1, 0, 4, 0, 8].positions).to eq output
    end
  end

  context "immutability (value objects)" do
    specify "two units of the same class with the same values are equal" do
      expect(described_class[7, 5, 9, 6, 1, 2, 4, 3, 8]).to eq described_class[7, 5, 9, 6, 1, 2, 4, 3, 8]
    end
  end

  it "has the right type" do
    expect(described_class[1, 2, 3, 4, 5, 6, 7, 8, 9].type).to eq type
  end
end

module Sudoku
  describe Row do
    it_behaves_like "a Unit", "Row"
  end

  describe Column do
    it_behaves_like "a Unit", "Column"
  end

  describe Box do
    it_behaves_like "a Unit", "Box"
  end
end
