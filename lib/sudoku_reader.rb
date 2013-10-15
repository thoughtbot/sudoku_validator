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

  def each_value
    each_line {|line| line.each{|value| yield(line, value)}}
  end

  private
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
