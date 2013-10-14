require_relative './sudoku_board'

class SudokuValidator
  attr_reader :game
  def initialize(game_file)
    @game_file = game_file
  end

  def analyze
    @game = SudokuBoard.new @game_file
    status = check_game_status
    validity = check_game_validity
    [validity, status]
  end

  def check_game_status
    self.missing_data? ?  'incomplete' : 'complete'
  end

  def check_game_validity
    rows_valid = check_row_validity
    cols_valid = check_col_validity
    subgrids_valid = check_subgrid_validity
    (rows_valid && cols_valid && subgrids_valid) ? 'valid' : 'invalid'
  end

  def missing_data?
    !(game.board.flatten.index( 0 )).nil?
  end

  def check_row_validity
    rows_valid = true
    (1..9).each do |row|
      rows_valid &&= valid?(@game.row(row))
    end
    rows_valid
  end

  def check_col_validity
    cols_valid = true
    (1..9).each do |col|
      cols_valid &&= valid?(@game.col(col))
    end
    cols_valid
  end
  
  def check_subgrid_validity
    subgrids_valid = true
    (1..9).each do |subgrid|
      subgrids_valid &&= valid?(@game.sub_grid(subgrid))
    end
    subgrids_valid
  end

  def valid?(ary)
    tmp = ary.map { |e| e if e !=0}.compact
    tmp.uniq.size == tmp.size
  end
end
