class SudokuBoard
  #attr_accessor :row
  #attr_reader :col, []
  attr_reader :board

  def initialize(game_file)
    @board = []
    File.readlines(game_file).each do |line|
      row = convert_line_to_row(line)
      @board << row unless row.nil?
    end
  end

  def [] (row, col)
    @board[row-1][col-1]
  end

  def []= (row, col, value)
    @board[row-1][col-1] = value
  end

  def row(row)
    @board[row-1]
  end

  def col(col)
    column = []
    @board.each { |row| column << row[col-1] }
    column
  end

  def sub_grid(number)
    # SubGrids are numbered 1-9 like this:
    #   1,2,3
    #   4,5,6
    #   7,8.9
    row, col = sub_grid_start(number)
    s_grid = []
    3.times do
      3.times do
        s_grid << self[row,col]
        col += 1
      end
      row += 1; col -= 3
    end
    s_grid
  end

  def convert_line_to_row(line)
    line.chomp!.delete!('-+| ')
    return nil if line.empty?
    line.tr!('.','0')
    row = []
    line.each_char.map { |c| row << c.to_i }
    row
  end

  def sub_grid_start(sub_grid)
    row = ((sub_grid-1)/3)*3 + 1
    col = ((sub_grid-1)%3)*3 + 1
    [row,col]
  end

  def missing_data?
    !(self.board.flatten.index( 0 )).nil?
  end
end
