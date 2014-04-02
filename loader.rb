
require_relative 'sudoku'

class Loader	

    def self.load(path)
    	grid = Array.new()
    	File.open(path) do |f|
        	f.each_line do |line|
                # removes the vertical separator | and replaces it with a space 
    			line = line.gsub('|', ' ') 
                # the lines containing a + are horizontal separators, they are skipped
            	if !line.include? '+'   
            		grid << line.split(" ")	
            	end
          	end 	
        end
        return Sudoku.new(grid)
    end

end