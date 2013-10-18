require 'spec_helper'

describe SudokuReader do

  describe '.parse_line' do
    it 'returns an array' do
      parsed_line = SudokuReader.parse_line "8 5 9 |6 1 2 |4 3 7 "

      expect(parsed_line).to eq ["8", "5", "9", "6", "1", "2", "4", "3", "7"]

      parsed_line = SudokuReader.parse_line ". . . |. 8 . |. 7 . "

      expect(parsed_line).to eq [".", ".", ".", ".", "8", ".", ".", "7", "."]

      parsed_line = SudokuReader.parse_line "------+------+------"      

      expect(parsed_line).to be_nil
    end
  end

  describe '#read' do
    it 'reads and stores the file into an array' do
      reader = SudokuReader.new 
      reader.read fixture_path('valid_incomplete.sudoku')

      expect(reader.grid.length).to eq 9 # rows
      reader.grid.each do |row|
        expect(row.length).to eq 9 # columns
      end
      expect(reader.grid[0][4]).to eq "."
      expect(reader.grid[2][2]).to eq "4"
    end

  end
  
end