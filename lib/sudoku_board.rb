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
    @board
  end
  def [] (row, col)
    @board[row-1][col-1]
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
    row = []
    line.chomp!.delete!('-+| ')
    return nil if line.empty?
    line.tr!('.','0')
    line.each_char.map { |c| row << c.to_i }
    row
  end
  def sub_grid_start(number)
    row = case
          when number <=3 then 1
          when number <=6 then 4
          when number <=9 then 7
          end
    col = case
          when number %3 == 1 then 1
          when number %3 == 2 then 4
          when number %3 == 3 then 7
          end
    [row,col]
  end
end
