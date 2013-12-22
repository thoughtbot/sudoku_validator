class SudokuValidator
	def initialize(sudoku = [])
		@sudoku = sudoku
		@rows = get_rows
		@columns = get_columns
		@grids = get_grids
	end

	def get_rows
		@sudoku
	end

	def get_columns
    @sudoku.transpose
	end

	def get_grids
		a = @sudoku
		grids = []
	sub_grid = []
			
		(0..2).each do |j|
		(0..2).each do |i|
	      sub_grid <<  a[j][i]
	    end
	  end
	    
    grids << sub_grid
    sub_grid = []
(0..2).each do |j|
		(3..5).each do |i|
	      sub_grid <<  a[j][i]
	    end

    end
    	   
 grids << sub_grid
	  sub_grid = []
	   (0..2).each do |j|
			(6..8).each do |i|
	      sub_grid <<  a[j][i]
	    end
	   end

	   grids << sub_grid
	sub_grid = []
			
		(3..5).each do |j|
		(0..2).each do |i|
	      sub_grid <<  a[j][i]
	    end
	  end
	    
    grids << sub_grid
    sub_grid = []
(3..5).each do |j|
		(3..5).each do |i|
	      sub_grid <<  a[j][i]
	    end

    end
    	   
 grids << sub_grid
	  sub_grid = []
	 (3..5).each do |j|
			(6..8).each do |i|
	      sub_grid <<  a[j][i]
	    end
	   end


	   	sub_grid = []
			
		(6..8).each do |j|
		(0..2).each do |i|
	      sub_grid <<  a[j][i]
	    end
	  end
	    
    grids << sub_grid
    sub_grid = []
(6..8).each do |j|
		(3..5).each do |i|
	      sub_grid <<  a[j][i]
	    end

    end
    	   
 grids << sub_grid
	  sub_grid = []
	 (6..8).each do |j|
			(6..8).each do |i|
	      sub_grid <<  a[j][i]
	    end
	   end
	   
grids << sub_grid
		grids
	end

  def validate_row(row)
		row.collect{|i| i.to_i}.sort.join == "123456789"
	end

	def validate_column(column)
		column.collect{|i| i.to_i}.sort.join == "123456789"
  end

  def validate_grid(grid)
  	grid.collect{|i| i.to_i}.sort.join == "123456789"
  end


	def validate_rows
		@rows.each do |row|
			if validate_row(row)
				next
			else
				return false
			end
			return true
		end
  end

	def validate_columns
		@columns.each do |column|
			if validate_column(column)
				next
			else
				return false
			end
			return true
		end
  end

  def validate_grids
  		@grids.each do |grid|
  		if validate_grid(grid)
				next
			else
			  return false
			end
			return true
		end
  end

	def validate
		if validate_rows && validate_columns && validate_grids
			"This sudoku is valid."
		else
			"This sudoku is invalid."
		end
	end
end