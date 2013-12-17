require_relative '../../lib/assesses_sudoku_completeness'

describe AssessesSudokuCompleteness do
  let(:sudoku) { double('sudoku') }
  subject { AssessesSudokuCompleteness.new(sudoku) }

  it "returns true for complete sudokus" do
    expect(sudoku).to receive(:rows).and_return([
        [1,2,3,4,5,6,7,8,9],
        [2,3,4,5,6,7,8,9,1],
        [3,4,5,6,7,8,9,1,2],
        [4,5,6,7,8,9,1,2,3],
        [5,6,7,8,9,1,2,3,4],
        [6,7,8,9,1,2,3,4,5],
        [7,8,9,1,2,3,4,5,6],
        [8,9,1,2,3,4,5,6,7],
        [9,1,2,3,4,5,6,7,8]
      ])
    expect(subject.is_complete?).to be_true
  end

  it "returns false for incomplete sudokus" do
    expect(sudoku).to receive(:rows).and_return([
        [nil,2,3,4,5,6,7,8,9],
        [2,3,4,5,6,7,8,9,1],
        [3,4,5,6,7,8,9,1,2],
        [4,5,6,7,8,9,1,2,3],
        [5,6,7,8,9,1,2,3,4],
        [6,7,8,9,1,2,3,4,5],
        [7,8,9,1,2,3,4,5,6],
        [8,9,1,2,3,4,5,6,7],
        [9,1,2,3,4,5,6,7,8]
      ])
    expect(subject.is_complete?).to be_false
  end
end
