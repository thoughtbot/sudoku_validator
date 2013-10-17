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

  private
  def fill_blocks
    each_vertical_start_of_block do |i|
      each_horizontal_start_of_block do |j|
        each_line_in_block {|k| get_line_of_block(i, j, k)}
      end
    end
  end

  def get_line_of_block(vertical_start, horizontal_start, line_block)
    line = lines[horizontal_start * 3 + line_block]
    line_in_block = line.drop(vertical_start).first(3)
    index_of_block = vertical_start + horizontal_start
    @blocks[index_of_block] += line_in_block
  end

  def each_vertical_start_of_block
    0.step(6,3) do |index_of_subblock|
      yield(index_of_subblock)
    end
  end

  def loop_in_subblock
    3.times do |index_line_of_block|
      yield(index_line_of_block)
    end
  end
  alias :each_horizontal_start_of_block :loop_in_subblock
  alias :each_line_in_block :loop_in_subblock

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
