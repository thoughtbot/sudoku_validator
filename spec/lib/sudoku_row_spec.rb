require 'sudoku_row'

describe Sudoku::Row do

  it "is a value object" do
    r1 = Sudoku::Row[1, 2, 3]
    r2 = Sudoku::Row[1, 2, 3]

    expect(r1).to eq r2
  end

  it "can be converted back to an array" do
    r1 = Sudoku::Row[1, 2, 3]
    expect(r1.to_a).to eq [1, 2, 3]
  end

  it "can be complete" do
    r1 = Sudoku::Row[3, 7, 5, 2, 6, 8, 9, 1, 4]

    expect(r1).to be_complete
  end

  it "can be incomplete" do
    r1 = Sudoku::Row[3, 7, 5, 2, 0, 8, 9, 1, 4]

    expect(r1).not_to be_complete
  end

  it "can list each number and its position" do
    r1 = Sudoku::Row[3, 7, 5, 2, 0, 8, 3, 1, 4]

    output = {
      0 => 5,
      1 => 8,
      2 => 4,
      3 => [1, 7],
      4 => 9,
      5 => 3,
      7 => 2,
      8 => 6
    }
    expect(r1.positions).to eq output
  end

end
