Gem::Specification.new do |s|
  s.name    = 'sudoku_validator'
  s.version = '0.0.1'
  s.summary = 'Sudoku Validator exercise from Thoughtbot'
  s.author  = 'Dan Scotton'
  s.email   = 'danscotton@gmail.com'

  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.executables << 'sudoku-validator'
  s.require_path = "lib"
end
