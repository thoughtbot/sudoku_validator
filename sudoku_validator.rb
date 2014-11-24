require_relative './lib/sudoku_reader'
require_relative './lib/columnizer'
require_relative './lib/multiple_counter'
require_relative './lib/quadrantizer.rb'
require_relative './lib/matrixizer.rb'

puts Sudoku::Validator.new(ARGV[0]).validate