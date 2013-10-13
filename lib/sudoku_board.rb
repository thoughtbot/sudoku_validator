class SudokuBoard
  #attr_accessor :row
  #attr_reader :col, []

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
  def row= (row)
  end
  def col(col)
    column = []
    @board.each { |row| column << row[col-1] }
    column
  end
  def convert_line_to_row(line)
    row = []
    line.chomp!.delete!('-+| ')
    return nil if line.empty?
    line.tr!('[1-9].','[1-9]0')
    line.each_char.map { |c| row << c.to_i }
    row
  end
end
