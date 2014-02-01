require_relative 'lib/sudoku_puzzle'

puts Sudoku::Puzzle.new(ARGV[0]).status
  
