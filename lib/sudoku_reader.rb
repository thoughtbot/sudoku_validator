
module Sudoku

  class Validator
    attr_accessor :errors

    def initialize f
      @matrix = Sudoku::Matrixizer.new(f).to_matrix
      @errors = ''
    end

    def validate
      check_quadrants
      check_columns
      check_rows
      format_results
    end

    private

    def format_results
      @errors.empty? ? 'Valid' : "Invalid: #{@errors.strip}"
    end

    def rows
      @matrix
    end

    def columns
      Sudoku::Columnizer.new(@matrix).convert
    end

    def quadrant
      Sudoku::Quadrant.new(@matrix).convert
    end

    def check_rows
      validate_section(rows, 'Row')
    end

    def check_columns
      validate_section(columns, 'Column')
    end

    def check_quadrants
      validate_section(quadrant, 'Quadrant')
    end

    def validate_section(lines, group_type  )
      lines.each_with_index do |line, index|
        e = Sudoku::MultipleCounter.new(line).find_errors
        unless e.nil? || e.empty?
          @errors += "#{ErrorMessage.say(group_type, index, e)} "
        end
      end
    end


  end

  class ErrorMessage

    def self.say(group_type, group_number, message)
      messages = message.map {|k,v| "#{v} #{k}'s"}
      "#{group_type} #{group_number + 1} had #{messages.join(' and ')}"
    end
  end

end
