require_relative '../sudoku_validator'
require 'minitest/autorun'

class TestSudokuLine < Minitest::Test

  def test_accepts_valid_line
    assert Sudoku::Line.new("5 9 8 |7 3 6 |2 4 1 ").to_array
  end

  def test_rejects_invalid_line
    assert_nil Sudoku::Line.new('-').to_array
  end

  def test_converts_valid_line_to_array
    assert_equal ['5', '3', '2'], Sudoku::Line.new("5 |3 |2 ").to_array
  end

end

class TestSudokuArray < Minitest::Test

  def test_does_not_count_dots
    assert_equal({}, Sudoku::LineValidator.new(['.','.','.']).find_errors)
  end

  def test_counts_valid
    assert_equal({}, Sudoku::LineValidator.new(['5','4','.']).find_errors)
  end

  def test_returns_multiples
    assert_equal({"5" => 3, "4" => 2}, Sudoku::LineValidator.new(['5','4','.', '5', '5', '4']).find_errors)
  end

end

class TestErrorMessage < Minitest::Test
  def test_it_says_type_and_messages
    assert_equal "row 6 had 2 1's", Sudoku::ErrorMessage.say('row', 5, {"1" => 2})
  end

  def test_it_says_type_and_messages_multiple_wrong
    assert_equal "row 6 had 2 1's and 3 4's", Sudoku::ErrorMessage.say('row', 5, {"1" => 2, "4" => 3})
  end

end

class TestColumnizer < Minitest::Test
  def test_converts_properly
    assert_equal [[1,3],[2,4]], Sudoku::Columnizer.new([[1,2],[3,4]]).convert

    assert_equal [[1,4,7],[2,5,8],[3,6,9]], Sudoku::Columnizer.new([[1,2,3],[4,5,6],[7,8,9]]).convert
  end
end

class TestRowToQuadrant < Minitest::Test

end

# class TestSolutions < Minitest::Test
#   def test_it_reports_bad_column do
#     assert_equal "Invalid: column 9 has 3 7's", Sudoku::Validator.new('./files/invalid_right_column.sudoku').validate
#   end
# end
