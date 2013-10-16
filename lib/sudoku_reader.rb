class SudokuReader
  attr_reader :path

  def initialize(path)
    @path = path
    @lines = []
    @columns = []
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

  private
  def blocks
    return @blocks if @blocks.any?
    init_blocks
    fill_blocks
    @blocks
  end

  def fill_blocks
    block_vertical_number = block_horizontal_number = 0
    grid_size.times do |i|
      block_vertical_number += 3 if i%3 == 0
      columns[i].each_with_index do |value, j|
        block_horizontal_number += 1 if j%3 == 0
        block_number = (block_horizontal_number - 1 + block_vertical_number - 3)
        @blocks[block_number] << value
      end

      block_horizontal_number = 0
    end
  end

  def init_blocks
    grid_size.times { @blocks << [] }
  end

  def columns
    return @columns if @columns.any?
    init_columns
    each_line {|line| grid_size.times.each {|i| @columns[i] << line[i]}}
    @columns
  end

  def init_columns
    grid_size.times { @columns << [] }
  end

  def grid_size
    lines.first.count
  end

  def convert_line_to_values(line)
    unless separator?(line)
      @lines << line.split.map { |value| cleaned_value(value) }
    end
  end

  def separator?(line)
    line == "------+------+------\n"
  end

  def cleaned_value(value)
    value.gsub('|','').to_i
  end
end
