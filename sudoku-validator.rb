require_relative 'lib/sudoku_validator'
require_relative 'lib/sudoku_parser'
parser = SudokuParser.new(ARGV[0])
sudoku_in_multidimensional_array = parser.parse
validator = SudokuValidator.new(sudoku_in_multidimensional_array)
result = validator.validate
puts result