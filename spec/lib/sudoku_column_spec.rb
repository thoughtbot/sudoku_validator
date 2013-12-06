require 'sudoku_column'

describe Sudoku::Column do

  it "is a value object" do
    c1 = Sudoku::Column[4, 5, 6]
    c2 = Sudoku::Column[4, 5, 6]

    expect(c1).to eq c2
  end

end
