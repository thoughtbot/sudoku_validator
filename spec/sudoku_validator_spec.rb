require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_board'

describe 'SudokuValidator' do 
  
  describe 'valid game' do 
    it 'points out valid sudoku when completed' do 
      board = SudokuBoard.new('valid_complete.sudoku')
      expect(SudokuValidator.new(board).validate).to eq 'valid and complete sudoku'
    end

    it 'points out valid sudoku when incomplete' do 
      board = SudokuBoard.new('valid_incomplete.sudoku')
      expect(SudokuValidator.new(board).validate).to eq 'valid but incomplete sudoku'
    end
  end

  describe 'invalid game' do 
    it 'points out invalid but complete sudoku' do
      board = SudokuBoard.new('invalid_complete.sudoku')
      expect(SudokuValidator.new(board).validate).to eq 'complete but invalid sudoku'
    end

    it 'points out invalid and incomplete sudoku' do
      board = SudokuBoard.new('invalid_incomplete.sudoku')
      expect(SudokuValidator.new(board).validate).to eq 'incomplete and invalid sudoku'
    end
  end

end
