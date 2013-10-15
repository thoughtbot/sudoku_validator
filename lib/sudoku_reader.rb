class SudokuReader
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def grid
    fill_grid_from_file unless @grid
    @grid
  end

  def each_line
    grid.each {|line| yield(line)}
  end

  def each_value_by_line
    each_line {|line| line.each{|value| yield(line, value)}}
  end

  def each_value_by_column
    columns.each {|column| column.each{|value| yield(column, value)}}
  end

  private
  def columns
    return @columns if @columns
    init_grid
    each_line {|line| grid_size.times.each {|i| @columns[i] << line[i]}}
    @columns
  end

  def init_grid
    @columns = []
    grid_size.times do
      @columns << []
    end
  end

  def grid_size
    grid.first.count
  end

  def fill_grid_from_file
    @grid = []
    File.read(path).each_line {|line| convert_line_to_values(line)}
  end

  def convert_line_to_values(line)
    unless separator?(line)
      @grid << line.split.map { |value| cleaned_value(value) }
    end
  end

  def separator?(line)
    line == "------+------+------\n"
  end

  def cleaned_value(value)
    value.gsub('|','').to_i
  end
end
