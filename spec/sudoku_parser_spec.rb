require 'spec_helper'
require_relative '../lib/sudoku_parser'
describe SudokuParser do
	context "#parse" do
		it "returns the one row sudoku in an array" do
			parser = SudokuParser.new('examples/one_row.sudoku')
			result = parser.parse
		  result.should eq([[8,5, 9, 6, 1, 2, 4, 3, 7 ]])
		end

		it "returns the two sudoku in an array" do
			parser = SudokuParser.new('examples/two_row.sudoku')
			result = parser.parse
		  result.should eq([[8, 5, 9, 6, 1, 2, 4, 3, 7 ],[7 ,2, 3 ,8, 5, 4, 1, 6, 9]])
		end

		it "returns the three sudoku in an array" do
			parser = SudokuParser.new('examples/three_row.sudoku')
			result = parser.parse
		  result.should eq([[8,5, 9, 6, 1, 2, 4, 3, 7 ],[7 ,2, 3 ,8, 5, 4, 1, 6, 9],[1, 6, 4, 3, 7, 9, 5, 2, 8 ]])
		end

		it "returns the full sudoku in an array" do
			parser = SudokuParser.new('valid_complete.sudoku')
			result = parser.parse
		  result.should eq([[8, 5, 9, 6, 1, 2, 4, 3, 7],
		   								 [7, 2, 3, 8, 5, 4, 1, 6, 9],
		   								  [1, 6, 4, 3, 7, 9, 5, 2, 8], 
		   								   [9, 8, 6, 1, 4, 7, 3, 5, 2], 
		   								  [3, 7, 5, 2, 6, 8, 9, 1, 4], 
		   								  [2, 4, 1, 5, 9, 3, 7, 8, 6], 
		   								  [4, 3, 2, 9, 8, 1, 6, 7, 5], 
		   								  [6, 1, 7, 4, 2, 5, 8, 9, 3],
		   								   [5, 9, 8, 7, 3, 6, 2, 4, 1]])
		end
	end
end