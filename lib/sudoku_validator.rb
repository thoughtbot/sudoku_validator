class SudokuValidator
	def initialize(sudoku = [][])
		@sudoku = sudoku
		@rows = get_rows
		@columns = get_columns
		@grids = get_grids
	end

	def get_rows
	end

	def get_columns
	end

	def get_grids
	end

	def validate_rows
		@rows.each do |row|
			validate_row(row)
		end
  end

	def validate_row(row)
    
	end

	def validate_column(column)
  end

  def validate_grid(grid)
  end

	def validate_columns
		@columns.each do |column|
			validate_column(column)
		end
  end

  def validate_grids
  		@grids.each do |grid|
			validate_grid(grid)
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