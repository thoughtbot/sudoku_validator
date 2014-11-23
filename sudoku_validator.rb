require_relative './lib/sudoku_reader'
require_relative './lib/columnizer'
require_relative './lib/line_validator'
require_relative './lib/quadrantizer.rb'
require_relative './lib/matrixizer.rb'

ARGV.each do |arg|
  puts arg
end