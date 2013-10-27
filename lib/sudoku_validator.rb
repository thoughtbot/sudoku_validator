require 'Matrix'

class SudokuValidator
  def initialize(file=nil)
    return if file.nil?

    puzzle = []
    open(file).each do |line|
      row = line.gsub(/[|\-+]/, "")
      unless row.strip.empty?
        puzzle.push(row.split(' ').map{|x| x == '.' ? nil : x.to_i})
      end
    end

    @puzzle = Matrix.rows(puzzle)
  end

  def valid?
    return false if @puzzle.nil?
    return validate(@puzzle)
  end

  def complete?
    @puzzle.row_vectors.each do |row|
      return false if row.include? nil
    end
    true
  end

  def validate(puzzle)
    valid_puzzle?(puzzle) && valid_rows?(puzzle) && valid_columns?(puzzle) && valid_submatricies?(puzzle)
  end

  def valid_puzzle?(puzzle)
    puzzle.square? && (puzzle.row_count % 3) == 0
  end

  def valid_rows?(puzzle)
    puzzle.row_vectors.each do |row|
      return false unless grouping_valid?(row)
    end

    true
  end

  def valid_columns?(puzzle)
    puzzle.column_vectors.each do |column|
      return false unless grouping_valid?(column)
    end

    true
  end

  def valid_submatricies?(puzzle)
    (puzzle.row_count / 3).times do |row|
      (puzzle.column_count / 3).times do |column|
        subpuzzle = puzzle.minor(3*row..(3*row)+2, 3*column..(3*column)+2)
        flattened = []
        subpuzzle.row_vectors.each do |subrow|
          flattened += subrow.to_a
        end
        return false unless grouping_valid?(flattened)
      end
    end

    true
  end

  def grouping_valid?(set)
    values = Hash.new(0)
    set.each do |value|
      values[value] += 1 unless value == nil
    end

    values.find{|k, v| v > 1 } == nil
  end
end
