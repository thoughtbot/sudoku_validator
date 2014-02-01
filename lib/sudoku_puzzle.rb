module Sudoku
  class Puzzle
    attr_reader :parsed_data, :rows, :cols, :boxes
    # The BoxOfIndex global constant concept is inspired from the book "The Ruby Programming Language" - by Flanagan and Matsumoto
    BoxOfIndex = [0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,
        3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,
        6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8].freeze

    def initialize(filename)
      mode = "r"
      file = File.open(filename, mode)
      puzzle_data = file.read
      file.close
      @parsed_data = puzzle_data.to_s.scan(/(\d|\.)/).flatten
      raise "Invalid Sudoku puzzle found in the input file" unless @parsed_data.length == 81
      
      # Construct the 27 array's of elements that need to be unique for a valid sudoku puzzle
      # There are 9 rows which will be extracted from the parsed_data using row
      # There are 9 columns which will be extracted from the parsed_data using col
      # There are 9 boxes which will be extracted from the parsed_data using the BoxOfIndex array

      
      # This is the custom looping concept for the Sudoku puzzle
      # There should be 9 rows, 9 cols and 9 boxes - Each element of parsed data will belong to one row, col and box
      @rows = Array.new
      @cols = Array.new
      @boxes = Array.new
      
      0.upto 8 do |index|
        @rows[index] = Array.new
        @cols[index] = Array.new
        @boxes[index] = Array.new
      end
      
      0.upto 8 do |row|
        0.upto 8 do |col|
          index = row*9 + col      # Cell index for (row, col)
          box = BoxOfIndex[index]
          @rows[row] << parsed_data[index]
          @cols[col] << parsed_data[index]
          @boxes[box] << parsed_data[index]
        end
      end
    end

    def is_incomplete?
      @parsed_data.include?(".")
    end

    def is_valid?
      # If the puzzle is incomplete we can strip the "." from the 27 array's 
      # After the stripping the array's must have unique elements for it to be valid
      0.upto 8 do |index|
        rows[index].reject! { |x| x == "."}
        cols[index].reject! { |x| x == "."}
        boxes[index].reject! { |x| x == "."}
      end
      !has_duplicates?
    end

    def has_duplicates?
      0.upto(8) { |row| return true if @rows[row].uniq! } 
      0.upto(8) { |col| return true if @cols[col].uniq! } 
      0.upto(8) { |box| return true if @boxes[box].uniq! } 
  
      false
    end

    def status
      if is_valid?
        if is_incomplete?
          "This sudoku is valid, but incomplete."
        else
          "This sudoku is valid."
        end
      else
          "This sudoku is invalid."
      end
    end
  end

end 