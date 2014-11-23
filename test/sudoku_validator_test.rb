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






