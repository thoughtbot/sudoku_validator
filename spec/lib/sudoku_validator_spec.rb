require 'spec_helper'
require 'yaml'

describe SudokuValidator do

  def create_validator(file_path=fixture_path('valid_complete.sudoku'))
    SudokuValidator.new(file_path)
  end

  describe '#valid_array?' do
    it 'returns false if there are repeats excluding "."' do
      validator = create_validator
      expect(validator.valid_array?(["1", "2", "3"])).to be_true
      expect(validator.valid_array?(["1", "2", "3", "3"])).to be_false
      expect(validator.valid_array?(["1", "2", ".", "."])).to be_true
    end
  end

  describe '#complete_array?' do
    it 'returns false if the number elements have count of 9 excluding "."' do
      validator = create_validator
      expect(validator.complete_array?(["1", "2", ".", "."])).to be_false
      expect(validator.complete_array?(["1", "2", "3", "4", "5", "6", "7", "8", "."])).to be_false
      expect(validator.complete_array?(["1", "2", "3", "4", "5", "6", "7", "8", "8"])).to be_true
    end
  end

  describe '#array_ok?' do
    it 'calls valid_array? if :invalid is given and returns the opposite' do
      validator = create_validator
      some_array = [1,2,3]
      
      expect(validator).to receive(:valid_array?).with(some_array).once.and_return(false)
      expect(validator.array_is?(:invalid, some_array)).to be_true
      expect(validator).to receive(:valid_array?).with(some_array).once.and_return(true)
      expect(validator.array_is?(:invalid, some_array)).to be_false
    end

    it 'calls complete_array? if :incomplete is given and returns the opposite' do
      validator = create_validator
      some_array = [1,2,3]
      
      expect(validator).to receive(:complete_array?).with(some_array).once.and_return(false)
      expect(validator.array_is?(:incomplete, some_array)).to be_true
      expect(validator).to receive(:complete_array?).with(some_array).once.and_return(true)
      expect(validator.array_is?(:incomplete, some_array)).to be_false
    end
  end

  describe '#initialize' do
    it 'takes a filepath and stores the grid' do
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
      validator = create_validator('valid_incomplete.sudoku')
      
      expect(validator.subgrid(3)).to eq ["4", ".", ".", ".", ".", "9", ".", ".", "."]
      expect(validator.subgrid(7)).to eq [".", ".", ".", ".", "1", "7", ".", ".", "."]
    end
  end

  describe '#validate!' do
    it 'runs finds and logs all the errors' do
      validator = create_validator('invalid_incomplete.sudoku')
      validator.validate!
      expect(validator.errors[:invalid][:row]).to eq []
      expect(validator.errors[:invalid][:column]).to eq [2, 5]
      expect(validator.errors[:invalid][:subgrid]).to eq []
      expect(validator.errors[:incomplete][:row]).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
      expect(validator.errors[:incomplete][:column]).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
      expect(validator.errors[:incomplete][:subgrid]).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
  end

  describe '#error_messages' do
    it 'ouputs the correct error messages' do
      validator = create_validator('invalid_incomplete.sudoku')
      validator.validate!

      expect(validator.error_messages(:invalid)).to eq [
        "invalid columns: 2, 5"
      ]
      expect(validator.error_messages(:incomplete)).to eq [
        "incomplete columns: 1, 2, 3, 4, 5, 6, 7, 8, 9",
        "incomplete rows: 1, 2, 3, 4, 5, 6, 7, 8, 9",
        "incomplete subgrids: 1, 2, 3, 4, 5, 6, 7, 8, 9"
      ]
    end
  end

  describe '#valid?' do
    it 'validates all 3 array checks' do
      validator = create_validator('valid_complete.sudoku')
      validator.validate!
      expect(validator.valid?).to be_true

      validator = create_validator('valid_incomplete.sudoku')
      validator.validate!
      expect(validator.valid?).to be_true

      validator = create_validator('invalid_complete.sudoku')
      validator.validate!
      expect(validator.valid?).to be_false

      validator = create_validator('invalid_incomplete.sudoku')
      validator.validate!
      expect(validator.valid?).to be_false
    end
  end

  describe '#complete?' do
    it 'validates all 3 array checks' do
      validator = create_validator('valid_complete.sudoku')
      validator.validate!
      expect(validator.complete?).to be_true

      validator = create_validator('valid_incomplete.sudoku')
      validator.validate!
      expect(validator.complete?).to be_false

      validator = create_validator('invalid_incomplete.sudoku')
      validator.validate!
      expect(validator.complete?).to be_false

      validator = create_validator('invalid_complete.sudoku')
      validator.validate!
      expect(validator.complete?).to be_true
    end
  end

  
end