class AssessesSudokuValidity < Struct.new(:sudoku)
  def is_valid?
    [sudoku.rows, sudoku.columns, sudoku.blocks].all? { |superset|
      superset.all? { |set| set_is_valid?(set) }
    }
  end

  def errors
    [:rows, :columns, :blocks].each_with_object({}) { |set_name, errors_hash|
      errors_hash[set_name] = errors_for_superset(set_name)
    }
  end

  private
  def set_is_valid?(set)
    set.compact.uniq.length == set.compact.length
  end

  def errors_for_superset(set_name)
    sudoku.send(set_name).each_with_index.each_with_object({}) { |(set, index), errors|
      duplicates = duplicates_for_set(set)
      errors[index + 1] = duplicates unless duplicates.empty?
    }
  end

  def duplicates_for_set(set)
    set.group_by{ |number| number }.select{ |number, count| count.size > 1 }.keys.compact
  end
end
