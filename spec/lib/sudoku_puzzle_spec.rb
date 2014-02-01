require 'spec_helper'
require 'sudoku_puzzle'

describe Sudoku::Puzzle do 
  it 'correctly validates invalid complete sudoku' do
     puzzle = Sudoku::Puzzle.new('invalid_complete.sudoku')
     expect(puzzle.status).to eq('This sudoku is invalid.')
  end

  it 'correctly validates valid complete sudoku' do
     puzzle = Sudoku::Puzzle.new('valid_complete.sudoku')
     expect(puzzle.status).to eq('This sudoku is valid.')
  end

  it 'correctly validates invalid incomplete sudoku' do
     puzzle = Sudoku::Puzzle.new('invalid_incomplete.sudoku')
     expect(puzzle.status).to eq('This sudoku is invalid.')
  end

  it 'correctly validates valid incomplete sudoku' do
     puzzle = Sudoku::Puzzle.new('valid_incomplete.sudoku')
     expect(puzzle.status).to eq('This sudoku is valid, but incomplete.')
  end

end