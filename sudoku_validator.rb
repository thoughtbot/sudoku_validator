require_relative 'loader'
require_relative 'sudoku'

def answer(sudoku)
	answer = "This Sudoku is " + ( sudoku.valid ? "valid" : "invalid") + " and " + (sudoku.complete ? "complete" : "incomplete") + "."
	puts answer
end

ARGV.each do|a|
	sudoku = Loader.load(a)
  	answer(sudoku)
end



	
