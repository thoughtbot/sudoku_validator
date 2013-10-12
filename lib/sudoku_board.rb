class SudokuBoard
  def initialize(game_file)
    @board = [[8]]
  end
  def [] (row, col)
    @board[row-1][col-1]
  end
end
