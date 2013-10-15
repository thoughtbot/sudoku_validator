class SudokuReader
  attr_accessor :lines

  def initialize(path)
    @lines = []
    File.read(path).each_line do |line|
      unless separator?(line)
        lines << line.split(' ').map { |value| cleaned_value(value) }
      end
    end
  end

  private

  def separator?(line)
    line == "------+------+------\n"
  end

  def cleaned_value(value)
    value.gsub('|','').to_i
  end
end
