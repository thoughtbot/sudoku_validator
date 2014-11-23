module Sudoku


  class Quadrant
    attr_accessor :columns
    def initialize matrix
      @matrix = matrix
      @square_root = Math.sqrt(@matrix.count).to_i
      @quadrants = []
    end

    def convert
      initialize_new_quadrants_matrix
      map_quadrants
      @quadrants
    end


    def initialize_new_quadrants_matrix
      @matrix.count.times {@quadrants << []}
    end

    def map_quadrants
      @matrix.length.times do |x|
        @matrix.length.times do |y|
          @quadrants[find_quadrant(x,y)] << @matrix[x][y]
        end
      end
    end

    def find_quadrant(x,y)
     row    = (x / @square_root) * @square_root
     column = (y / @square_root)
     row + column
    end

  #   0 1 2
  # 0 0 1 2
  # 1 3 4 5
  # 2 6 7 8
  end

end

#Sudoku::Array.new(['1','.','.']).validate
# Sudoku::Validator.new('./text/valid_complete').validate

#Sudoku::Validator.new('~/projects/throwaway/Sudoku_validator/test/files/valid_complete.Sudoku').validate
 #
 # f_path = (File.expand_path File.dirname(__FILE__)) + '/test/files'
 # Sudoku::Validator.new(f_path + '/invalid_complete.sudoku').validate

 # q = Sudoku::Quadrant.new(s).convert