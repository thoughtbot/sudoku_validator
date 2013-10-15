class SudokuValidator
  def initialize(reader)
    @reader = reader
  end

  def complete?
    @reader.each_line {|line| return false if line.include?(0)}
    return true
  end

  def valid?
    @reader.each_value do |line, value|
      return false if line.count(value) > 1 && value != 0
    end
    return true
  end
end
