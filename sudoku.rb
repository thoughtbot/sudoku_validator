class Sudoku

	attr_reader :valid, :complete

	def initialize(grid)  
    	@grid = grid  
    	@complete = nil
    	@valid = nil 
    	validate_grid
	end 

	protected
	def validate_row(line_number)
		line = @grid[line_number]
		validate(line)
	end

	def validate_column(column_number)
		# we are arranging all elements of the column in a single array fot the validation
		line = Array.new()
		@grid.each do |l|
			line << l[column_number]
		end
		validate(line)
	end

	def validate_subgrid(subgrid_number)
		# Each sudoku subgrid was assigned a subgrid_number as follow 
		# 0 | 1 | 2
		# 3 | 4 | 5
		# 6 | 7 | 8 
		# (i,j) is the upper left element of the subgrid 
		i = (subgrid_number / 3) * 3
		j = (subgrid_number - i) * 3

		# we are arranging all elements of the sub grid in a single array for the validation
		line = Array.new()
		for k in 0..2
			line += @grid[i+k][j..j+2]
		end
		validate(line)
	end

	# validates wether a given array of 9 elements contains a distinct sublist of numbers from 1 to 9
	def validate(line)
		check = Array.new(9)
		line.each do |element|
			element = element.to_i 
			# Any non numerical element will return 0 
			if element == 0 
				@complete = false
			else
				if check[element - 1] != nil
					@valid = false
				else
					check[element - 1] = 1
				end
			end	
		end
	end

	def validate_grid
		for i in 0..8
			validate_row(i)
			validate_column(i)
			validate_subgrid(i)
		end 
		if @valid == nil
			@valid = true
		end
		if @complete == nil
			@complete = true
		end
	end

end