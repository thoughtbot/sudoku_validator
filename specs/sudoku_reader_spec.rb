require 'minitest'
require 'minitest/autorun'
require_relative '../lib/board_reader'


class TestMacbethAnalyzer < MiniTest::Test

  describe '#read' do
    def test_read_valid_board_returns_11_rows
      array = Sudoku::BoardReader.new('./specs/valid_test_board.sudoku').read
      assert_equal( array.count, 11 )
    end
    def test_read_valid_board_returns_correct_row
      array = Sudoku::BoardReader.new('./specs/valid_test_board.sudoku').read
      assert_equal( "8 5 9 |6 1 2 |4 3 7", array[0] )
    end
    def test_read_error_board
      board_reader = Sudoku::BoardReader.new('./specs/invalid_error_board.sudoku')
      #puts board_reader.read
      assert_raises(RuntimeError) { board_reader.read }
    end
  end
end

