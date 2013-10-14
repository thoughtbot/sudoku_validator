require_relative './sudoku_board'

class SudokuValidator
  attr_reader :game, :errors

  def initialize(game_file)
    @game_file = game_file
    @game = SudokuBoard.new @game_file
    @errors = []
  end

  def analyze
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
    !(@game.board.flatten.index( 0 )).nil?
  end

  def check_row_validity
    rows_valid = true
    (1..9).each do |row|
      valid,error = valid?(@game.row(row))
      rows_valid &&= valid
      error.each { |e| @errors << "#{e} is repeated in row #{row}" }
    end
    rows_valid
  end

  def check_col_validity
    cols_valid = true
    (1..9).each do |col|
      valid,error = valid?(@game.col(col))
      cols_valid &&= valid
      error.each { |e| @errors << "#{e} is repeated in col #{col}" }
    end
    cols_valid
  end
  
  def check_subgrid_validity
    subgrids_valid = true
    (1..9).each do |subgrid|
      valid,error = valid?(@game.sub_grid(subgrid))
      subgrids_valid &&= valid
      error.each { |e| @errors << "#{e} is repeated is subgrid #{subgrid}" }
    end
    subgrids_valid
  end

  def valid?(ary)
    tmp = ary.map { |e| e if e !=0}.compact
    valid = tmp.uniq.size == tmp.size
    error = []
    error = report_errors(ary) if !valid
    [valid,error]
  end

  def report_errors (ary)
    tmp = ary
    error = []
    while tmp.size > 0 do
      item = tmp.shift
      error << item if tmp.include? item
    end
    error
  end
end
