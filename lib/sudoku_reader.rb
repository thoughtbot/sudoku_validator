module Sedoku

  class Validator
    attr_accessor :errors

    def initialize f
      @matrix = Sedoku::Sfile.new(f).to_matrix
    end

    def validate
      check_rows
      check_columns
      errors
    end

    private

    def check_rows
      errors += @matrix.map {|line| LineValidator.new(line).find_errors}
    end

    def check_columns
      @columns = Sedoku::Column.new(@matrix).convert
      errors += @matrix.map {|line| LineValidator.new(line).find_errors}
    end

    # def check_quadrants
    #   @quadrants = Sudoku::Quadrant.new(@matrix).convert
    # end
  end

  class Column
    attr_accessor :columns
    def initialize matrix
      @matrix = matrix
      @columns = []
    end

    def convert
      initialize_new_columns_matrix
      map_rows_to_columns
      @columns
    end

    def map_rows_to_columns
      @matrix.map {|row| map_row(row)}
    end

    def map_row(row)
      row.each_with_index {|item, index| push_column(index, item) }
    end

    def push_column(index,item)
      @columns[index] << item
    end

    private

    def initialize_new_columns_matrix
      @matrix.count.times {@columns << []}
    end
  end

  class Quadrant
    attr_accessor :columns
    def initialize matrix
      @matrix = matrix
      @square_root = Math.sqrt(@matrix.count).to_i
      @quadrants = []
    end

    def convert
      initialize_new_quadrants_matrix
      map_rows_to_quadrants
      @quadrants
    end


    def initialize_new_quadrants_matrix
      @matrix.count.times {@quadrants << []}
    end

    #Looking at rows
    def map_rows_to_quadrants
      @square_root.times {|num| map_group_to_quadrants(num)}
    end

    #looking at columns in a row
    def map_group_to_quadrant(num)
      @square_root.times do |time|
        group = @matrix.shift

      end
    end




  end

  class Sfile

    def initialize relative_file_path
      @file = File.open(relative_file_path)
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

  class LineValidator
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

  class ErrorMessage

    def self.say(group_type, group_number, message)
      messages = message.map {|k,v| "#{v} #{k}'s"}
      "#{group_type.downcase} #{group_number + 1} had #{messages.join(' and ')}"
    end
  end

end

#Sedoku::Array.new(['1','.','.']).validate
# Sedoku::Validator.new('./text/valid_complete').validate

#Sedoku::Validator.new('~/projects/throwaway/sedoku_validator/test/files/valid_complete.sedoku').validate

f_path = (File.expand_path File.dirname(__FILE__)) + '/test/files'
Sedoku::Validator.new(f_path + '/invlaid_complete.sedoku').validate
