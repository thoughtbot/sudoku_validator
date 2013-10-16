class SudokuReader
  attr_reader :path

  def initialize(path)
    @path = path
    @lines = []
    @blocks = []
  end

  def lines
    return @lines if @lines.any?
    File.read(path).each_line {|line| convert_line_to_values(line)}
    @lines
  end

  def each_line
    lines.each {|line| yield(line)}
  end

  def each_value_by_line
    each_line {|line| line.each{|value| yield(line, value)}}
  end

  def each_value_by_column
    columns.each {|column| column.each{|value| yield(column, value)}}
  end

  def each_value_by_block
    blocks.each {|block| block.each{|value| yield(block, value)}}
  end

  def columns
    @columns ||= lines.transpose
  end

  def blocks
    return @blocks if @blocks.any?
    init_empty_blocks
    fill_blocks
    @blocks
  end

  def fill_blocks
    0.step(6,3) do |k|
      3.times do |i|
        3.times {|j| @blocks[k+i] += lines[i*3+j][k..k+2]}
      end
    end
  end

  private
  def init_empty_blocks
    9.times { @blocks << [] }
  end

  def convert_line_to_values(line)
    unless separator?(line)
      @lines << line.split.map { |value| sanitize(value) }
    end
  end

  def separator?(line)
    line == "------+------+------\n"
  end

  def sanitize(value)
    value.gsub('|','').to_i
  end
end
