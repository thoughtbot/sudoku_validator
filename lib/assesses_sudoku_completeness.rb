class AssessesSudokuCompleteness < Struct.new(:sudoku)
  def is_complete?
    sudoku.rows.all?(&:all?)
  end
end
