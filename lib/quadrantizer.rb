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

  end

end
