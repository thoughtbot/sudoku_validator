require_relative './sudoku_board'

class SudokuValidator
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def validate
    if valid_rows_columns_grids && contains_empty_points
      'valid but incomplete sudoku'
    elsif valid_rows_columns_grids && !contains_empty_points
      'valid and complete sudoku'
    elsif !valid_rows_columns_grids && contains_empty_points
      'incomplete and invalid sudoku'
    elsif !valid_rows_columns_grids && !contains_empty_points
      'complete but invalid sudoku'
    end
  end

    private
    def valid_rows_columns_grids
      check_rows && check_columns && check_subgrids
    end

    def check_rows
      board.rows.none? do |row|
        check_for_duplicates(row)
      end
    end

    def check_columns
      board.columns.none? do |column|
        check_for_duplicates(column)
      end
    end

    def check_subgrids
      board.subgrids.none? do |subgrid|
        check_for_duplicates(subgrid)
      end
    end

    def check_for_duplicates(elements)
      elements.any? { |n| elements.count(n) > 1 unless n == 0 }
    end

    def contains_empty_points
      board.rows.any? do |row|
        any_zeros?(row)
      end
    end

    def any_zeros?(element)
      element.any? { element.count(0) >= 1 }
    end
end
