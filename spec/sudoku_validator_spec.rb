require 'spec_helper'
require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_parser'
describe SudokuValidator do
	context "#validate" do
		it "validates one row" do
			parser = SudokuParser.new('examples/one_row.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		it "validates two row" do
			parser = SudokuParser.new('examples/two_row.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		it "validates three row" do
			parser = SudokuParser.new('examples/two_row.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		it "validates complete sudoku rows" do
			parser = SudokuParser.new('valid_complete.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end
	end
end