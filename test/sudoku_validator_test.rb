require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sudoku_validator'

class SudokuFileParserTest < MiniTest::Unit::TestCase
  def test_reads_file_into_9x9_2d_array
    parser = SudokuFileParser.new('test/valid_complete.sudoku')

    assert_equal(9, parser.grid.size)
    parser.grid.each { |row| assert_equal(9, row.size) }
  end

  def test_parses_as_strings
    expected = 
      [['8', '5', '.', '.', '.', '2', '4', '.', '.'],
       ['7', '2', '.', '.', '.', '.', '.', '.', '9'],
       ['.', '.', '4', '.', '.', '.', '.', '.', '.'],
       ['.', '.', '.', '1', '.', '7', '.', '.', '2'],
       ['3', '.', '5', '.', '.', '.', '9', '.', '.'],
       ['.', '4', '.', '.', '.', '.', '.', '.', '.'],
       ['.', '.', '.', '.', '8', '.', '.', '7', '.'],
       ['.', '1', '7', '.', '.', '.', '.', '.', '.'],
       ['.', '.', '.', '.', '3', '6', '.', '4', '.']]

    parser = SudokuFileParser.new('test/valid_incomplete.sudoku')
    assert_equal(expected, parser.grid)
  end
end
