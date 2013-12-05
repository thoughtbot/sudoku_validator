require 'matrix'

class SudokuBoard
  attr_reader :board, :rows
  def initialize(file)
    @rows = []

    File.readlines(file).each do |line|
      row = get_row_from line
      @rows << row unless row.empty?
    end
    @board = Matrix.rows(@rows)
  end

  def point(row, col)
    board.[](row - 1, col - 1)
  end

  def row(n)
    board.row(n-1).to_a
  end

  def column(n)
    board.column(n-1).to_a
  end

  def subgrid(starting_row, starting_col)
    board.minor(starting_row - 1, 3, starting_col - 1, 3).to_a.flatten!
  end

  def columns
    columns = (1..9).collect do |n|
      column(n)
    end
  end

  def subgrids
    subgrids = []
    [1,4,7].each do |n|
      [1,4,7].each do |x|
        subgrids << subgrid(n, x)
      end
    end
    subgrids
  end

    private
    def get_row_from(line)
      line.chomp!.delete!('-+| ').tr!('.', '0')
      row = line.each_char.collect(&:to_i)
    end
end
