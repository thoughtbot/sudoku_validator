module Sudoku

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

end

#Sudoku::Array.new(['1','.','.']).validate
# Sudoku::Validator.new('./text/valid_complete').validate

#Sudoku::Validator.new('~/projects/throwaway/Sudoku_validator/test/files/valid_complete.Sudoku').validate
 #
 # f_path = (File.expand_path File.dirname(__FILE__)) + '/test/files'
 # Sudoku::Validator.new(f_path + '/invalid_complete.sudoku').validate
