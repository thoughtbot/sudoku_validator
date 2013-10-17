#sudoku.rb
#takes one argument: the .sudoku file to analyze

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

	def check_sudoku
		
		c = check_columns
		l = check_lines
		valid = c[0] && l[0]
		complete = c[1] && l[1]

		p 'sudoku is valid' if valid
		p 'sudoku is complete' if complete
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
mySudoku.printlines


# mySudoku.values.each do |l|
# 	p l+ "  complete: "+Sudoku.complete?(l)+" valid: "+Sudoku.valid?(l)
# end




# for y in 1..3
# 	puts ""
# 	75.times {print '-'}
# 	for x in 1..3
# 		puts ""
# 		for j in 1..3
# 			print " | "
# 			for k in 1..3
# 				print "(#{(y-1)*3+x}, #{(j-1)*3+k}) "
# 			end
# 		end
# 	end
# end