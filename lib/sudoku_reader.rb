
class SudokuReader

  def self.reader_from_file(file_path)
    reader = SudokuReader.new
    reader.read(file_path)
    reader
  end

  attr_reader :grid

  def initialize
    @grid = []
  end

  def read(file_path)
    open(file_path).each do |line|
      parsed_line = parse_line line
      @grid << parsed_line if parsed_line
    end
  end

  def parse_line(line)
    line.split(/[^\d\.]+/) unless separator_line? line
  end

  def separator_line?(line)
    line =~/^-+/
  end
end