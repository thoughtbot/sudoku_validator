class SudokuParser
	def initialize(file)
		@file = File.new(file, "r")
	end

	def parse
		sudoku_array = []
		counter = 1
    while (line = @file.gets)
    	next if line.index('-')
    	line = remove_bars(line)
    	sudoku_array << convert_string_to_array(line).collect{|i| i.to_i}
    end
    @file.close
		sudoku_array
  end

  def remove_bars(line)
    line.gsub('|', '')   
  end
  def convert_string_to_array(string)
  	string.split(' ')
  end
end