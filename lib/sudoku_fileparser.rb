module Sudoku
  class FileParser
    def initialize(file = nil)
      raise(ArgumentError, "A file is required.") if file.nil?
      @file = file
    end

    def parse_rows
      @file.strip.each_line.map do |line|
        parse_line(line) unless separator?(line)
      end.compact
    end

    private

    def parse_line(line)
      parse_empties(line).delete("\n|").split(" ").map(&:to_i)
    end

    def parse_empties(line)
      line.gsub(".", "0")
    end

    def separator?(line)
      line.start_with?('-')
    end
  end
end
