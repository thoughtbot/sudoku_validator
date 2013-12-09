Feature: Validating .sudoku files

  Scenario: A valid, complete sudoku
    When I successfully run `sudoku-validator ./valid_complete.sudoku`
    Then the output should contain "This sudoku is valid."

  Scenario: A valid, incomplete sudoku
    When I successfully run `sudoku-validator ./valid_incomplete.sudoku`
    Then the output should contain "This sudoku is valid, but incomplete."

  Scenario: An invalid, complete sudoku
    When I successfully run `sudoku-validator ./invalid_complete.sudoku`
    Then the output should contain "This sudoku is invalid."
    Then the output should contain "Column 4 contains a duplicate 8 in squares 2 and 5."
    Then the output should contain "Column 6 contains a duplicate 2 in squares 1 and 5."

  Scenario: An invalid, incomplete sudoku
    When I successfully run `sudoku-validator ./invalid_incomplete.sudoku`
    Then the output should contain "This sudoku is invalid."
