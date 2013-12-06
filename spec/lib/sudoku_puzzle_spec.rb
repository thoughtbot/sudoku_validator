require 'sudoku_puzzle'

# "This sudoku is invalid."
# "- Row 1 contains a duplicate 5 in squares 1 and 3."
# "- Column 4 contains a duplicate 3 in squares 3 and 9."
# "- Box 5 contains a duplicate 11 in squares 1 and 2."

# [
#   {
#     :type => :row,
#     :number => "5",
#     :positions => [1, 3]
#   }
# ]

# errors = {
#   :row => [
#     {
#       :number => 1,
#       :value => 5,
#       :squares => [1, 3]
#     }
#   ],
#
#   :row => {
#     1 => [
#       {
#         :number  => 5,
#         :squares => [1, 3]
#       },
#       {
#         :number  => 1,
#         :squares => [2, 4]
#       }
#     ]
#   }
# }

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

  it "responds to :complete?"

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
