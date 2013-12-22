require 'spec_helper'
require_relative '../lib/sudoku_parser'
describe SudokuParser do
	context "#parse" do
		it "returns the sudoku in an array" do
			parser = SudokuParser.new('one_row.sudoku')
			result = parser.parse
		  result.should eq([8,5, 9, 6, 1, 2, 4, 3, 7 ])
		end

		it "returns the sudoku in an array" do
			parser = SudokuParser.new('one_row.sudoku')
			result = parser.parse
		  result.should eq([[8,5, 9, 6, 1, 2, 4, 3, 7 ],[7 ,2, 3 ,8, 5, 4, 1, 6, 9]])
		end
	end
end