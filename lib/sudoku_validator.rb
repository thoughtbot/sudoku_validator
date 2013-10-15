class SudokuValidator
  def initialize(reader)
    @reader = reader
  end

  def complete?
    @reader.grid.each do |line|
      return false if line.include?(0)
    end
    return true
  end
end
