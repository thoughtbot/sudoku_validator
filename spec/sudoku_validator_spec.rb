require 'spec_helper'
require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_parser'
describe SudokuValidator do
	context "#validate" do
		it "validates one row valid" do
			parser = SudokuParser.new('examples/one_row.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		it "validates two row valid" do
			parser = SudokuParser.new('examples/two_row.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		it "validates three row valid" do
			parser = SudokuParser.new('examples/three_row.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		it "validates one row invalid" do
			parser = SudokuParser.new('examples/one_row_invalid.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is invalid.")
		end

		it "validates one three invalid" do
			parser = SudokuParser.new('examples/three_row_invalid.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is invalid.")
		end

		it "validates complete valid sudoku rows" do
			parser = SudokuParser.new('valid_complete.sudoku')
			sudoku_in_multidimensional_array = parser.parse
			validator = SudokuValidator.new(sudoku_in_multidimensional_array)
			result = validator.validate
      result.should eq("This sudoku is valid.")
		end

		# it "validates complete invalid sudoku rows" do
		# 	parser = SudokuParser.new('invalid_complete.sudoku')
		# 	sudoku_in_multidimensional_array = parser.parse
		# 	validator = SudokuValidator.new(sudoku_in_multidimensional_array)
		# 	result = validator.validate
  #     result.should eq("This sudoku is valid.")
		# end
	end
end