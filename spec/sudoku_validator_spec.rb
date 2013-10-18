require_relative '../lib/sudoku_validator'
require_relative '../lib/sudoku_reader.rb'

describe SudokuValidator do
  describe "#complete?" do
    context "with complete sudokus" do
      it "give true" do
        ['valid_complete.sudoku', 'invalid_complete.sudoku'].each do |file|
          expect(validator_for(file)).to be_complete
        end
      end
    end

    context "with incomplete sudokus" do
      it "give false" do
        ['valid_incomplete.sudoku', 'invalid_incomplete.sudoku'].each do |file|
          expect(validator_for(file)).to_not be_complete
        end
      end
    end
  end

  describe "#valid?" do
    context "with valid sudokus" do
      it "give true" do
        ['valid_complete.sudoku', 'valid_incomplete.sudoku'].each do |file|
          expect(validator_for(file)).to be_valid
        end
      end
    end

    context "with invalid sudokus" do
      it "give true" do
        ['invalid_complete.sudoku',
         'invalid_incomplete.sudoku',
         'invalid_column.sudoku',
         'invalid_block.sudoku',
         'invalid_line.sudoku'].each do |file|
          expect(validator_for(file)).to_not be_valid
        end
      end
    end
  end

  describe "#message" do
    context "when the sudoku is valid" do
      context "when the sudoku is complete" do
        it "say than the sudoku is valid" do
          file = 'valid_complete.sudoku'
          expect(validator_for(file).message).to eq "This sudoku is valid."
        end
      end

      context "when the sudoku is incomplete" do
        it "say than the sudoku is valid" do
          file = 'valid_incomplete.sudoku'
          expect(validator_for(file).message).to eq "This sudoku is valid, but incomplete."
        end
      end
    end

    context "when the sudoku is invalid" do
      it "say than the sudoku is invalid" do
        ['invalid_complete.sudoku', 'invalid_incomplete.sudoku'].each do |file|
          expect(validator_for(file).message).to match "This sudoku is invalid."
        end
      end

      context "when the sudoku is invalid du to lines" do
        it "say than there is an error in line" do
          file = 'invalid_line.sudoku'
          expect(validator_for(file).message).to match "There is multiple 5 in line 1."
        end
      end
    end
  end

  def validator_for(file)
    SudokuValidator.new(SudokuReader.new(file))
  end
end
