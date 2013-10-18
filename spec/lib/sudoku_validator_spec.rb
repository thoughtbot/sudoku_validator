require 'spec_helper'

describe SudokuValidator do

  describe '.valid_array?' do
    it 'returns false if there are repeats excluding "."' do
      expect(SudokuValidator.valid_array?(["1", "2", "3"])).to be_true
      expect(SudokuValidator.valid_array?(["1", "2", "3", "3"])).to be_false
      expect(SudokuValidator.valid_array?(["1", "2", ".", "."])).to be_true
    end
  end

  describe '.complete_array?' do
    it 'returns false if the number elements have count of 9 excluding "."' do
      expect(SudokuValidator.complete_array?(["1", "2", ".", "."])).to be_false
      expect(SudokuValidator.complete_array?(["1", "2", "3", "4", "5", "6", "7", "8", "."])).to be_false
      expect(SudokuValidator.complete_array?(["1", "2", "3", "4", "5", "6", "7", "8", "8"])).to be_true
    end
  end

  describe '#initialize' do
    it 'stores the grid' do
      reader = SudokuReader.new
      reader.read(fixture_path('valid_incomplete.sudoku'))
      validator = SudokuValidator.new reader.grid

      expect(validator.grid).to eq reader.grid
    end

    it 'optionally takes a filepath' do
      reader = SudokuReader.new
      reader.read(fixture_path('valid_incomplete.sudoku'))

      validator = SudokuValidator.new fixture_path('valid_incomplete.sudoku')

      expect(validator.grid).to eq reader.grid
    end
  end

  describe '#row' do
    it 'retrieves a row as an array' do
      validator = SudokuValidator.new fixture_path('valid_incomplete.sudoku')

      expect(validator.row(1)).to eq ["8", "5", ".", ".", ".", "2", "4", ".", "."]
      expect(validator.row(5)).to eq ["3", ".", "5", ".", ".", ".", "9", ".", "."]
    end
  end

  describe '#column' do
    it 'retrieves a column as an array' do
      validator = SudokuValidator.new fixture_path('valid_incomplete.sudoku')

      expect(validator.column(2)).to eq ["5", "2", ".", ".", ".", "4", ".", "1", "."]
      expect(validator.column(4)).to eq [".", ".", ".", "1", ".", ".", ".", ".", "."]
    end
  end

  describe '#subgrid' do
    # subgrid is laid out as below
    #       1       2       3   <- grid_column_index
    #     1 - 3   4 - 6   7 - 9
    #   1 . . . | . . . | . . .
    # 1 | . 1 . | . 2 . | . 3 .
    #   3 . . . | . . . | . . .
    #     +-----+-------+-----+
    #   4 . . . | . . . | . . .
    # 2 | . 4 . | . 5 . | . 6 .
    #   6 . . . | . . . | . . .
    #     +-----+-------+-----+
    #   7 . . . | . . . | . . .
    # 3 | . 7 . | . 8 . | . 9 .
    #   9 . . . | . . . | . . .
    #
    # ^
    # grid_row_index
    #

    it 'retrieves a subgrid as an array' do
      validator = SudokuValidator.new fixture_path('valid_incomplete.sudoku')

      expect(validator.subgrid(3)).to eq ["4", ".", ".", ".", ".", "9", ".", ".", "."]
      expect(validator.subgrid(7)).to eq [".", ".", ".", ".", "1", "7", ".", ".", "."]
    end
  end

  describe '#valid?' do
    
    it 'validates all 3 array checks' do
      validator = SudokuValidator.new fixture_path('valid_complete.sudoku')
      expect(validator.valid?).to be_true

      validator = SudokuValidator.new fixture_path('valid_incomplete.sudoku')
      expect(validator.valid?).to be_true

      validator = SudokuValidator.new fixture_path('invalid_complete.sudoku')
      expect(validator.valid?).to be_false

      validator = SudokuValidator.new fixture_path('invalid_incomplete.sudoku')
      expect(validator.valid?).to be_false
    end
  end

  describe '#complete?' do
    
    it 'validates all 3 array checks' do
      validator = SudokuValidator.new fixture_path('valid_complete.sudoku')
      expect(validator.complete?).to be_true

      validator = SudokuValidator.new fixture_path('invalid_complete.sudoku')
      expect(validator.complete?).to be_true

      validator = SudokuValidator.new fixture_path('valid_incomplete.sudoku')
      expect(validator.complete?).to be_false

      validator = SudokuValidator.new fixture_path('invalid_incomplete.sudoku')
      expect(validator.complete?).to be_false
    end
  end

end