#sudoku.rb
#takes one argument: the .sudoku file to analyze

#right now duplicates the completeness check
#didn't use TDD because I don't know how to outside of Rails 

class Sudoku
	@values = []

	def initialize(args)
		@values = args
	end

	def values
		@values
	end

	def valid?(arr)
		meat = []
		arr.each do |element|
			meat.push(element) unless '.'.include?(element)
		end
		meat.length == meat.uniq.length
	end

	def complete?(arr)
		ret = false
		arr.each do |element|
			ret = ret || ['.'].include?(element)
		end
		return !ret
	end

	def check_lines
		valid=true
		complete=true

		@values.each do |line|
			valid = valid && valid?(line)
			complete = complete && complete?(line)
		end
		return valid, complete
	end

	def check_columns
		valid=true
		complete=true
		
		for i in 1..9
			column=[]
			for j in 1..@values.length
				column.push(@values[j-1][i-1])
			end
			valid = valid && valid?(column)
			complete = complete && complete?(column)
		end
		return valid, complete
	end

	def printlines
		@values.each do |line|
			p line
		end
	end

	def check_squares
		valid=true
		complete=true


		for y in 1..3

			for x in 1..3
				box = []
				for j in 1..3
					for k in 1..3
						box.push(@values[(x-1)*3+j-1][(y-1)*3+k-1])
					end
				end
				valid = valid && valid?(box)
				complete = complete && complete?(box)
			end
		end
		return valid, complete
	end

	def check_sudoku
		
		c = check_columns
		l = check_lines
		q = check_squares
		valid = q[0] && l[0] && c[0]
		complete = q[1] && l[1] && c[0]

		if valid
			p 'Sudoku is valid'
		else
			p 'Sudoku is invalid'
		end

		if complete
			p 'Sudoku is complete'
		else
			p 'Sudoku is incomplete'
		end

	end

end

grid=[]
accepted=['1','2','3','4','5','6','7','8','9',"."]

infile = File.open(ARGV[0]).readlines




infile.to_enum.with_index(1).each do |line, i|
	short = []
	line.split("").each do |c|
		short.push(c) if accepted.include?(c) 
	end

	grid.push(short) if short.length > 0

end
mySudoku = Sudoku.new(grid)


mySudoku.check_sudoku

