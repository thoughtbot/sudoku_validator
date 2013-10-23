require 'spec_helper'

describe SudokuReader do

  let(:reader) { SudokuReader.new }

  describe '#parse_line' do
    it 'returns an array' do
      parsed_line = reader.parse_line "8 5 9 |6 1 2 |4 3 7 "

      expect(parsed_line).to eq ["8", "5", "9", "6", "1", "2", "4", "3", "7"]

      parsed_line = reader.parse_line ". . . |. 8 . |. 7 . "

      expect(parsed_line).to eq [".", ".", ".", ".", "8", ".", ".", "7", "."]

      parsed_line = reader.parse_line "------+------+------"      

      expect(parsed_line).to be_nil
    end
  end

  describe '#separator_line?' do
    it 'returns true if the line is -----' do
      line = "------+------+------"

      expect(reader.separator_line?(line)).to be_true

      line = "8 5 9 |6 1 2 |4 3 7 "

      expect(reader.separator_line?(line)).to be_false

      line = ". . . |. 8 . |. 7 . "

      expect(reader.separator_line?(line)).to be_false
    end
  end

  describe '#read' do
    it 'reads and stores the file into an array' do
      reader.read fixture_path('valid_incomplete.sudoku')

      expect(reader.grid.length).to eq 9 # rows
      reader.grid.each do |row|
        expect(row.length).to eq 9 # columns
      end
      expect(reader.grid[0][4]).to eq "."
      expect(reader.grid[2][2]).to eq "4"
    end
  end
  
  describe '#reader_from_file' do
    it 'creates an instance of reader with a grid generated from file' do
      reader = SudokuReader.reader_from_file(fixture_path('valid_incomplete.sudoku'))
      
      expect(reader.grid.length).to eq 9
      expect(reader.grid[0][4]).to eq "."
      expect(reader.grid[2][2]).to eq "4"
    end
  end
end