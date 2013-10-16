class SudokuValidator
  attr_accessor :reader

  def initialize(reader)
    @reader = reader
  end

  def complete?
    reader.each_line {|line| return false if line.include?(0)}
    return true
  end

  def valid?
    lines_valid? && columns_valid? && blocks_valid?
  end

  private
  def lines_valid?
    check_validity_for(:line)
  end

  def columns_valid?
    check_validity_for(:column)
  end

  def blocks_valid?
    check_validity_for(:block)
  end

  def check_validity_for(type)
    reader.send("each_value_by_#{type}") do |row, value|
      return false if row.count(value) > 1 && value != 0
    end
    return true
  end
end
