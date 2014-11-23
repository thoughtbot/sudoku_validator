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
    attr_accessor :grouped_array, :counts_hash

    def initialize line_array
      @line_array = line_array
      @counts_hash = {}
    end

    def find_errors
      reject_dot_character
      generate_counts_hash
      return_only_multiples
    end

    private

    def return_only_multiples
      @counts_hash.reject!{|k,v| v == 1}
      @counts_hash || {}
    end

    def generate_counts_hash
      @line_array.each {|char| add_to_counts_hash(char)}
    end

    def add_to_counts_hash(char)
      if counts_hash[char]
        counts_hash[char] += 1
      else
        counts_hash[char] = 1
      end
    end



    def reject_dot_character
      @line_array.reject! {|char| char == '.'}
    end

  end
end

#Sedoku::Array.new(['1','.','.']).validate