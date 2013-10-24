require_relative 'lib/board_reader'
require_relative 'lib/board_validator'

raise 'Missing input file - SudokuValidator <filename>' if ARGV.length != 1
board = Sudoku::BoardValidator.new(Sudoku::BoardReader.new(ARGV[0]).read)
puts board.valid_board?

