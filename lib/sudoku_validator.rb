require_relative './sudoku_board'

class SudokuValidator
  attr_reader :game
  def initialize(game_file)
    @game_file = game_file
  end

  def analyze
    @game = SudokuBoard.new @game_file
    if self.missing_data?
      status = 'incomplete'
    else
      status = 'complete'
    end
  end

  def missing_data?
    !(game.board.flatten.index( 0 )).nil?
  end

end
