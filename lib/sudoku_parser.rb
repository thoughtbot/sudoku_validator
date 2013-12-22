class SudokuParser
	def initialize(file)
		@file = File.new(file, "r")
		@sudoku_array = []
	end

	def parse
		sudoku_string = ""
		counter = 1
    while (line = @file.gets)
    	line = remove_bars(line)
      sudoku_string += line
    end
    @sudoku_array = convert_string_to_array(sudoku_string)
    @sudoku_array = @sudoku_array.collect{|i| i.to_i}
    @file.close
		@sudoku_array
  end

  def remove_bars(line)
    line.gsub('|', '')   
  end
  def convert_string_to_array(string)
  	string.split(' ')
  end
end