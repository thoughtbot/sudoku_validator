module Sudoku

  class Validator
    attr_accessor :errors

    def initialize f
      @matrix = Sudoku::Matrixizer.new(f).to_matrix
    end

    def validate
      check_rows
      check_columns
      @errors
    end

    private

    def check_rows
      @errors ||= @matrix.map {|line| LineValidator.new(line).find_errors}
    end

    def check_columns
      @columns = Sudoku::Column.new(@matrix).convert
      @errors += @matrix.map {|line| LineValidator.new(line).find_errors}
    end

    # def check_quadrants
    #   @quadrants = Sudoku::Quadrant.new(@matrix).convert
    # end
  end

  class ErrorMessage

    def self.say(group_type, group_number, message)
      messages = message.map {|k,v| "#{v} #{k}'s"}
      "#{group_type.downcase} #{group_number + 1} had #{messages.join(' and ')}"
    end
  end

end

#Sudoku::Array.new(['1','.','.']).validate
# Sudoku::Validator.new('./text/valid_complete').validate

#Sudoku::Validator.new('~/projects/throwaway/Sudoku_validator/test/files/valid_complete.Sudoku').validate
 #
 # f_path = (File.expand_path File.dirname(__FILE__)) + '/test/files'
 # Sudoku::Validator.new(f_path + '/invalid_complete.sudoku').validate
