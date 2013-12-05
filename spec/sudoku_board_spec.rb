require_relative '../lib/sudoku_board'

describe 'SudokuBoard' do 
  before do 
    @incomplete_board = SudokuBoard.new('valid_incomplete.sudoku')
    @complete_board = SudokuBoard.new('valid_complete.sudoku')
  end

  describe '#row' do 
    it 'returns the row when passed an index' do
      expect(@complete_board.row(2)).to eq [7,2,3,8,5,4,1,6,9]
    end

    it 'reurns the row with zeros if the board is incomplete' do 
      expect(@incomplete_board.row(3)).to eq [0,0,4,0,0,0,0,0,0]
    end
  end

  describe '#column' do
    it 'returns the expected column for the valid and complete file' do
      expect(@complete_board.column(1)).to eq [8,7,1,9,3,2,4,6,5]
    end

    it 'returns the expected column for the valid and incomplete file' do
      expect(@incomplete_board.column(4)).to eq [0,0,0,1,0,0,0,0,0]
    end
  end

  describe '#subgrid' do 
    it 'returns a given subgrid' do 
      expect(@complete_board.subgrid(4, 4)).to eq [1,4,7,2,6,8,5,9,3]
    end

    it 'returns a given subgrid for valid incomplete sudoku' do
      expect(@incomplete_board.subgrid(7, 7)).to eq [0,7,0,0,0,0,0,4,0]
    end
  end

  describe '#point' do
    it 'returns the value at a given point' do 
      expect(@complete_board.point(3,5)).to eq 7
    end
  end

  describe '#columns' do 
    it 'returns all the columns from the board' do 
      expect(@complete_board.columns).to eq [[8,7,1,9,3,2,4,6,5],[5,2,6,8,7,4,3,1,9],
        [9,3,4,6,5,1,2,7,8],[6,8,3,1,2,5,9,4,7],[1,5,7,4,6,9,8,2,3],[2,4,9,7,8,3,1,5,6],
        [4,1,5,3,9,7,6,8,2], [3,6,2,5,1,8,7,9,4], [7,9,8,2,4,6,5,3,1]]
    end
  end

  describe '#subgrids' do 
    it 'returns all the subgrids frim the board' do 
      expect(@incomplete_board.subgrids).to eq [[8,5,0,7,2,0,0,0,4],
        [0,0,2,0,0,0,0,0,0], [4,0,0,0,0,9,0,0,0], [0,0,0,3,0,5,0,4,0],[1,0,7,0,0,0,0,0,0],
        [0,0,2,9,0,0,0,0,0], [0,0,0,0,1,7,0,0,0],[0,8,0,0,0,0,0,3,6], [0,7,0,0,0,0,0,4,0]]
    end
  end
end
