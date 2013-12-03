require 'sudoku_fileparser'

describe Sudoku::FileParser do
  it "throws an ArgumentError if instantiated without a file" do
    expect { Sudoku::FileParser.new }.to raise_error(ArgumentError)
  end

  it "can parse rows out of the file into a simple array format" do
    parser = Sudoku::FileParser.new(example_file)
    parser.parse_rows.should eq [
      %w{ 0 5 9 6 1 2 4 3 0 },
      %w{ 7 0 3 8 5 4 1 0 9 },
      %w{ 1 6 0 3 7 9 0 2 8 },
      %w{ 9 8 6 0 4 0 3 5 2 },
      %w{ 3 7 5 2 0 8 9 1 4 },
      %w{ 2 4 1 0 9 0 7 8 6 },
      %w{ 4 3 0 9 8 1 0 7 5 },
      %w{ 6 0 7 4 2 5 8 0 3 },
      %w{ 0 9 8 7 3 6 2 4 0 }
    ]
  end

  def example_file
    %Q{
. 5 9 |6 1 2 |4 3 . 
7 . 3 |8 5 4 |1 . 9 
1 6 . |3 7 9 |. 2 8 
------+------+------
9 8 6 |. 4 . |3 5 2 
3 7 5 |2 . 8 |9 1 4 
2 4 1 |. 9 . |7 8 6 
------+------+------
4 3 . |9 8 1 |. 7 5 
6 . 7 |4 2 5 |8 . 3 
. 9 8 |7 3 6 |2 4 .
    }
  end
end
