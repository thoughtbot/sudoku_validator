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
    valid_element?('row')
  end

  def check_col_validity
    valid_element?('col')
  end
  
  def check_subgrid_validity
    valid_element?('sub_grid')
  end

  def valid_element?(element)
    item_valid = true
    (1..9).each do |item|
      valid, error = valid?(@game.__send__(element.to_sym,item))
      item_valid &&= valid
      report_errors(error, element, item)
    end
    item_valid
  end

  def valid?(ary)
    tmp = ary.map { |e| e if e !=0}.compact
    valid = tmp.uniq.size == tmp.size
    error = []
    error = identify_errors(ary) if !valid
    [valid,error]
  end

  def identify_errors (ary)
    tmp = ary.clone
    error = []
    while tmp.size > 0 do
      item = tmp.shift
      error << item if tmp.include? item
    end
    error
  end

  def report_errors (ary,where,item)
    ary.each { |e| @errors << "#{e} is repeated in #{where} #{item}" }
  end
end
