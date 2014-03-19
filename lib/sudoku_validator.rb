class SudokuFileParser
  attr_reader :grid

  def initialize(filename)
    contents = IO.read(filename)
    stripped = strip_unnecessary(contents)
    @grid = gridify(stripped)
  end

  private

  def strip_unnecessary(contents)
    contents.gsub(/[^\d\.]/, '')
  end

  def gridify(stripped)
    stripped.chars.each_slice(9).to_a
  end
end
