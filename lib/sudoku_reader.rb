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
    lines.each_with_index {|line, index| yield(line, index)}
  end

  def each_value_by_line
    each_line {|line, index| line.each{|value| yield(line, value, index)}}
  end

  def each_value_by_column
    columns.each_with_index do |column, index|
      column.each{|value| yield(column, value, index)}
    end
  end

  def each_value_by_block
    blocks.each_with_index do |block, index|
      block.each{|value| yield(block, value, index)}
    end
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

  private
  def fill_blocks
    each_block do |block_number|
      line, column = block_start(block_number)
      each_line_in_block {|k| get_line_of_block(line, column, k)}
    end
  end

  def block_start(block_number)
    row = ((block_number) / 3) * 3
    col = ((block_number) % 3) * 3
    [row,col]
  end

  def get_line_of_block(vertical_start, horizontal_start, line_block)
    line = lines[horizontal_start + line_block]
    line_in_block = line.drop(vertical_start).first(3)
    index_of_block = vertical_start + horizontal_start/3
    @blocks[index_of_block] += line_in_block
  end

  def each_block
    9.times {|block_number| yield(block_number)}
  end

  def each_line_in_block
    3.times {|index_line_of_block| yield(index_line_of_block)}
  end

  def init_empty_blocks
    9.times { @blocks << [] }
  end

  def convert_line_to_values(line)
    @lines << line.split.map { |value| sanitize(value) } unless separator?(line)
  end

  def separator?(line)
    line == "------+------+------\n"
  end

  def sanitize(value)
    value.gsub('|','').to_i
  end
end
