require_relative '../sudoku_validator'
require 'minitest/autorun'

class TestSedokuToArray < Minitest::Test

end

class TestSedokuLine < Minitest::Test

  def test_accepts_valid_line
    assert Sedoku::Line.new("5 9 8 |7 3 6 |2 4 1 ").to_array
  end

  def test_rejects_invalid_line
    assert_nil Sedoku::Line.new('-').to_array
  end

  def test_converts_valid_line_to_array
    assert_equal ['5', '3', '2'], Sedoku::Line.new("5 |3 |2 ").to_array
  end

end

class TestSedokuArray < Minitest::Test

  def test_does_not_count_dots
    assert_equal({}, Sedoku::Array.new(['.','.','.']).find_errors)
  end

  def test_counts_valid
    assert_equal({}, Sedoku::Array.new(['5','4','.']).find_errors)
  end

  def test_returns_multiples
    assert_equal({"5" => 3, "4" => 2}, Sedoku::Array.new(['5','4','.', '5', '5', '4']).find_errors)
  end

end

class TestErrorMessage < Minitest::Test
  def test_it_says_type_and_messages
    assert_equal "row 6 had 2 1's", Sedoku::ErrorMessage.say('row', 5, {"1" => 2})
  end

  def test_it_says_type_and_messages_multiple_wrong
    assert_equal "row 6 had 2 1's and 3 4's", Sedoku::ErrorMessage.say('row', 5, {"1" => 2, "4" => 3})
  end

end



