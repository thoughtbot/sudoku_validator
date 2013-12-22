require 'spec_helper'
require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_parser'
describe SudokuValidator do
	context "#validate" do
		it "validates sudoku" do
			parser = SudokuParser.new('../valid_incomplete.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end
	end
end