
class SudokuReader

  attr_reader :grid

  def self.parse_line(line)
    # sample: "8 5 9 |6 1 2 |4 3 7 "
    line.split("|").map { |segment| segment.split(" ") }.flatten unless line =~ /^-+/
  end

  def initialize
    @grid = []
  end

  def read(file_path)
    open(file_path).each do |line|
      parsed_line = SudokuReader.parse_line line
      @grid << parsed_line if parsed_line
    end
  end
end