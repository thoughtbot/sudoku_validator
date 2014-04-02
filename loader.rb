
require_relative 'sudoku'

class Loader	

    def self.load(path)
    	grid = Array.new(9){Array.new(9)}
    	File.open(path) do |f|
        	i = 0
        	f.each_line do |line|
                # removes the vertical separator | and replaces it with a space 
    			line = line.gsub('|', ' ') 
                # the lines containing a + are horizontal separators, they are skipped
            	if !line.include? '+'   
            		grid[i] = line.split(" ")
            		i += 1
            	end
          	end 	
        end
        return Sudoku.new(grid)
    end

end