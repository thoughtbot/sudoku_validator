require 'minitest'
require 'minitest/autorun'
require_relative 'lib/board_reader'
require_relative 'lib/board_validator'


require 'minitest/autorun'

module MiniTest::Assertions
  def assert_contains(string, substring)
    assert string.include?(substring), "Expected #{string} to contain #{substring}"
  end
end
String.infect_an_assertion :assert_contains, :must_contain, :only_one_argument



class TestMacbethAnalyzer < MiniTest::Test

  describe '#initialize' do
    def setup
      @test_board = [
          "1 1 1 |1 1 1 |1 1 1",
          "2 2 2 |2 2 2 |2 2 2",
          "3 3 3 |3 3 3 |3 3 3",
          "------+------+------",
          "4 4 4 |4 4 4 |4 4 4",
          "5 5 5 |5 5 5 |5 5 5",
          "6 6 6 |6 6 6 |6 6 6",
          "------+------+------",
          "7 7 7 |7 7 7 |7 7 7",
          "8 8 8 |8 8 8 |8 8 8",
          "9 9 9 |9 9 9 |9 9 9"
      ]
      @exception_board = [
          "      |1 1 1 |1 1 1",
          "2 2 2 |2 2 2 |2 2 2",
          "3 3 3 |3 3 3 |3 3 3",
          "------+------+------",
          "4 4 4 |4 4 4 |4 4 4",
          "5 5 5 |5 5 5 |5 5 5",
          "6 6 6 |6 6 6 |6 6 6",
          "------+------+------",
          "7 7 7 |7 7 7 |7 7 7",
          "8 8 8 |8 8 8 |8 8 8",
          "9 9 9 |9 9 9 |9 9 9"
      ]
      @board_not_complete = [
          "1 1 1 |1 1 1 |1 1 1",
          "2 2 2 |2 2 2 |2 2 2",
          "3 3 3 |3 3 3 |3 3 3",
          "------+------+------",
      ]

    end
    def test_valid_validator_input
      board = Sudoku::BoardValidator.new @test_board
      board.inspect.to_s.must_contain(
        'rows=[["1", "1", "1", "1", "1", "1", "1", "1", "1"], '+
              '["2", "2", "2", "2", "2", "2", "2", "2", "2"], '+
              '["3", "3", "3", "3", "3", "3", "3", "3", "3"], '+
              '["4", "4", "4", "4", "4", "4", "4", "4", "4"], '+
              '["5", "5", "5", "5", "5", "5", "5", "5", "5"], '+
              '["6", "6", "6", "6", "6", "6", "6", "6", "6"], '+
              '["7", "7", "7", "7", "7", "7", "7", "7", "7"], '+
              '["8", "8", "8", "8", "8", "8", "8", "8", "8"], '+
              '["9", "9", "9", "9", "9", "9", "9", "9", "9"]]'
      )

      board.inspect.to_s.must_contain(
        'cols=[["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"], '+
              '["1", "2", "3", "4", "5", "6", "7", "8", "9"]]'
      )
      board.inspect.to_s.must_contain(
        'grids=[["1", "1", "1", "2", "2", "2", "3", "3", "3"], '+
               '["1", "1", "1", "2", "2", "2", "3", "3", "3"], '+
               '["1", "1", "1", "2", "2", "2", "3", "3", "3"], '+
               '["4", "4", "4", "5", "5", "5", "6", "6", "6"], '+
               '["4", "4", "4", "5", "5", "5", "6", "6", "6"], '+
               '["4", "4", "4", "5", "5", "5", "6", "6", "6"], '+
               '["7", "7", "7", "8", "8", "8", "9", "9", "9"], '+
               '["7", "7", "7", "8", "8", "8", "9", "9", "9"], '+
               '["7", "7", "7", "8", "8", "8", "9", "9", "9"]]'
      )
    end
    def test_incomplete_board
      assert_raises(RuntimeError) { Sudoku::BoardValidator.new @board_not_complete }
    end
    def test_invalid_entries_board
      assert_raises(RuntimeError) { Sudoku::BoardValidator.new @exception_board }
    end
  end
  describe '#valid_board?' do
    def setup
      @valid_board = [
          "4 5 2 |6 1 8 |9 7 3",
          "3 1 8 |2 7 9 |5 4 6",
          "7 9 6 |4 5 3 |8 1 2",
          "------+------+------",
          "2 4 7 |8 9 6 |1 3 5",
          "9 3 1 |5 4 7 |2 6 8",
          "8 6 5 |1 3 2 |7 9 4",
          "------+------+------",
          "5 2 9 |7 6 4 |3 8 1",
          "6 8 3 |9 2 1 |4 5 7",
          "1 7 4 |3 8 5 |6 2 9",
      ]
      @blank_board = [
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
      ]
      @invalid_row = [
          "1 . . |1 . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
      ]
      @invalid_col = [
          "1 . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          "1 . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
      ]
      @invalid_grid = [
          "1 . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . 1 |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          "------+------+------",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
          ". . . |. . . |. . .",
      ]
    end
    def test_valid_board
      assert_equal(Sudoku::BoardValidator.new(@valid_board).valid_board?, true )
    end
    def test_valid_empty_board
      assert_equal(Sudoku::BoardValidator.new(@blank_board).valid_board?, true )
    end
    def test_invalid_row
      assert_equal(Sudoku::BoardValidator.new(@invalid_row).valid_board?, false )
    end
    def test_invalid_col
      assert_equal(Sudoku::BoardValidator.new(@invalid_col).valid_board?, false )
    end
    def test_invalid_grid
      assert_equal(Sudoku::BoardValidator.new(@invalid_grid).valid_board?, false )
    end
  end
end

