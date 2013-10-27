require 'sudoku_validator'

describe SudokuValidator do
  before (:each) do
    @validator = SudokuValidator.new
  end

  it "has no duplicates in a row" do
    validPuzzle = Matrix[[1,2,3],[nil,nil,nil],[nil,nil,nil]]
    @validator.validate(validPuzzle).should be_true

    invalidPuzzle = Matrix[[1,1,2],[nil,nil,nil],[nil,nil,nil]]
    @validator.validate(invalidPuzzle).should be_false
  end

  it "has no duplicates in a column" do
    validPuzzle = Matrix[[1,nil,nil],[2,nil,nil],[3,nil,nil]]
    @validator.validate(validPuzzle).should be_true

    invalidPuzzle = Matrix[[1,nil,nil], [1,nil,nil], [2,nil,nil]]
    @validator.validate(invalidPuzzle).should be_false
  end

  it "has no duplicates in a sub-grid" do
    validPuzzle = Matrix[[1,2,3],[4,5,6],[7,8,9]]
    @validator.validate(validPuzzle).should be_true

    invalidPuzzle = Matrix[[1,2,3],[4,5,6],[7,8,1]]
    @validator.validate(invalidPuzzle).should be_false
  end

  it "validates files" do
    vc = SudokuValidator.new("valid_complete.sudoku")
    vc.valid?.should be_true
    vc.complete?.should be_true

    vi = SudokuValidator.new("valid_incomplete.sudoku")
    vi.valid?.should be_true
    vi.complete?.should be_false

    ic = SudokuValidator.new("invalid_complete.sudoku")
    ic.valid?.should be_false
    ic.complete?.should be_true

    ii = SudokuValidator.new("invalid_incomplete.sudoku")
    ii.valid?.should be_false
    ii.complete?.should be_false
  end
end
