require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_reader.rb'

describe SudokuValidator do
  before do
    allow(reader).to receive(:reader).and_return(reader)
  end

  shared_examples "a complete sudoku" do
    describe "#complete?" do
      context "when the sudoku is complete" do
        it "is compete" do
          expect(validator).to be_complete
        end
      end
    end
  end

  shared_examples "a incomplete sudoku" do
    describe "#complete?" do
      context "when the sudoku is incomplete" do
        it "is not complete" do
          expect(validator).to_not be_complete
        end
      end
    end
  end

  shared_examples "a valid sudoku" do
    describe "#valid?" do
      context "when the sudoku is valid" do
        it "is valid" do
          expect(validator).to be_valid
        end
      end
    end
  end

  shared_examples "a invalid sudoku" do
    describe "#valid?" do
      context "when the sudoku is invalid" do
        it "is not valid" do
          expect(validator).to_not be_valid
        end
      end
    end
  end

  describe "valid and complete sudoku" do
    it_behaves_like "a complete sudoku"
    it_behaves_like "a valid sudoku"

    def reader
      SudokuReader.new('valid_complete.sudoku')
    end
  end

  describe "valid an incomplete sudoku" do
    it_behaves_like "a incomplete sudoku"
    it_behaves_like "a valid sudoku"

    def reader
      SudokuReader.new('valid_incomplete.sudoku')
    end
  end

  describe "invalid an complete sudoku" do
    it_behaves_like "a complete sudoku"
    it_behaves_like "a invalid sudoku"

    def reader
      SudokuReader.new('invalid_complete.sudoku')
    end
  end

  describe "invalid an incomplete sudoku" do
    it_behaves_like "a incomplete sudoku"
    it_behaves_like "a invalid sudoku"

    def reader
      SudokuReader.new('invalid_incomplete.sudoku')
    end
  end

  describe "invalid lines and complete" do
    it_behaves_like "a complete sudoku"
    it_behaves_like "a invalid sudoku"

    def reader
      SudokuReader.new('invalid_complete.sudoku')
    end
  end

  describe "invalid columns and complete" do
    it_behaves_like "a complete sudoku"
    it_behaves_like "a invalid sudoku"

    def reader
      SudokuReader.new('invalid_column_complete.sudoku')
    end
  end

  describe "invalid subblock and incomplete" do
    it_behaves_like "a incomplete sudoku"
    it_behaves_like "a invalid sudoku"

    def reader
      SudokuReader.new('invalid_block_incomplete.sudoku')
    end
  end

  def validator
    @validator ||= SudokuValidator.new(reader)
  end
end
