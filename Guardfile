# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
 watch('Gemfile')
 watch('lib/sudoku_validator.rb')
  watch('spec/sudoku_validator_spec.rb')
  watch('spec/spec_helper.rb') { :rspec }
  
end

guard 'rspec', all_after_pass: false do
end

