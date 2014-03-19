require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'

require_relative '../lib/sudoku_validator'

class SudokuFileParserTest < MiniTest::Unit::TestCase
  def test_reads_file_into_9x9_2d_array
    parser = SudokuFileParser.new('test/valid_complete.sudoku')

    assert_equal(9, parser.grid.size)
    parser.grid.each { |row| assert_equal(9, row.size) }
  end

  def test_parses_as_strings
    expected = 
      [%w{8 5 . . . 2 4 . .},
       %w{7 2 . . . . . . 9},
       %w{. . 4 . . . . . .},
       %w{. . . 1 . 7 . . 2},
       %w{3 . 5 . . . 9 . .},
       %w{. 4 . . . . . . .},
       %w{. . . . 8 . . 7 .},
       %w{. 1 7 . . . . . .},
       %w{. . . . 3 6 . 4 .}]

    parser = SudokuFileParser.new('test/valid_incomplete.sudoku')
    assert_equal(expected, parser.grid)
  end
end

class RowValidatorTest < MiniTest::Unit::TestCase
  def test_valid_when_unique_in_row
    grid = [%w{1 2 3}, %w{3 2 1}]

    validator = RowValidator.new(grid)

    assert(validator.valid?)
  end

  def test_invalid_when_duplicates_in_row
    grid = [%w{1 2 3}, %w{3 2 3}]

    validator = RowValidator.new(grid)

    refute(validator.valid?)
  end

  def test_ignore_dots
    assert(RowValidator.new([['.', '.'], ['.', '.']]).valid?)
    assert(RowValidator.new([['.', '.'], ['1', '.']]).valid?)
    refute(RowValidator.new([['.', '.', '2'], ['1', '.', '1']]).valid?)
  end
end

class ColumnValidatorTest < MiniTest::Unit::TestCase
  def test_is_implemented_in_terms_of_row_validator_for_transposed_grid
    grid =[%w{1 2 3}, %w{4 5 6}]
    row_validator = mock()
    row_validator.expects(:valid?).returns(true)
    RowValidator
      .expects(:new)
      .with([%w{1 4}, %w{2 5}, %w{3 6}])
      .returns(row_validator)

    ColumnValidator.new(grid).valid?
  end
end

class SubgridValidatorTest < MiniTest::Unit::TestCase
  def test_is_implemented_in_terms_of_row_validator_for_modified_grid
    grid = 
      [%w{8 5 . . . 2 4 . .},
       %w{7 2 . . . . . . 9},
       %w{. . 4 . . . . . .},
       %w{. . . 1 . 7 . . 2},
       %w{3 . 5 . . . 9 . .},
       %w{. 4 . . . . . . .},
       %w{. . . . 8 . . 7 .},
       %w{. 1 7 . . . . . .},
       %w{. . . . 3 6 . 4 .}]

    modified_grid = 
      [%w{8 5 . 7 2 . . . 4},
       %w{. . 2 . . . . . .},
       %w{4 . . . . 9 . . .},
       %w{. . . 3 . 5 . 4 .},
       %w{1 . 7 . . . . . .},
       %w{. . 2 9 . . . . .},
       %w{. . . . 1 7 . . .},
       %w{. 8 . . . . . 3 6},
       %w{. 7 . . . . . 4 .}]

    row_validator = mock()
    row_validator.expects(:valid?).returns(true)
    RowValidator
      .expects(:new)
      .with(modified_grid)
      .returns(row_validator)

    SubgridValidator.new(grid).valid?
  end
end

