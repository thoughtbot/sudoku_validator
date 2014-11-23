module Sedoku
  class File
    attr_reader :matrix, :file

    def initialize relative_file_path
      @file = File.read(relative_file_path)
    end

    def to_matrix
      matrix = @file.each_line.collect{|line| SedokuLine.new(line).to_array}
      return matrix.reject! {|a| a.nil?}
    end


  end

  class Line
    def initialize line
      @line =  line
    end

    def to_array
      convert_to_array unless invalid?
    end

    private

    def invalid?
      @line[0] == '-'
    end

    def convert_to_array
      @line.each_char.reject{|char| bad_characters.include? char}
    end

    def bad_characters
      ['|', ' ', "\n"]
    end

  end

  class Array
    def initialize line_array
      @line_array = line_array
    end


  end
end
