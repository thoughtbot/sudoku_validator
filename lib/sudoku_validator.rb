require_relative './sudoku_board'

class SudokuValidator
  attr_reader :game
  def initialize(game_file)
    @game_file = game_file
  end

  def analyze
    @game = SudokuBoard.new @game_file
    status = check_game_status
    validity = 'valid'
    [validity, status]
  end

  def check_game_status
    self.missing_data? ?  'incomplete' : 'complete'
  end

  def missing_data?
    !(game.board.flatten.index( 0 )).nil?
  end

end
