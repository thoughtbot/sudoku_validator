class Grid
  attr_reader :squares, :edge_length

  def initialize(grid)
    @squares = grid
    @grid_length = @squares.length
    @edge_length = Math.sqrt(@squares.length).to_int
    @subgrid_edge_length = Math.sqrt(@edge_length).to_int
  end

  def row(n)
    @squares[@edge_length * n, @edge_length]
  end

  def column(n)
    indices = (n...@grid_length).step(@edge_length)
    indices.map { |i| @squares[i] }
  end

  def subgrid(n)
    # (subgrid_row, subgrid_column) subgrid_index
    # (0, 0) 0 | (0, 1) 1 | (0, 2) 2
    # (1, 0) 3 | (1, 1) 4 | (1, 2) 5
    # (2, 0) 6 | (2, 1) 7 | (2, 2) 8
    subgrid_row = n / @subgrid_edge_length * @subgrid_edge_length
    subgrid_column = n % @subgrid_edge_length

    start = subgrid_row * @subgrid_edge_length + subgrid_column # index of first subgrid element in @squares
    subgrid_indices = (start...(start + @edge_length)).step(@subgrid_edge_length)

    subsections = @squares.each_slice(@subgrid_edge_length).to_a
    subgrid_indices.map { |i| subsections[i] }.flatten
  end

  def complete?
    @squares.none? { |square| square.nil? }
  end
end
