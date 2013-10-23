require_relative '../lib/sudoku_reader'
require_relative '../lib/sudoku_validator'
require 'support/fixture_path'


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end