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

  Scenario: An invalid, incomplete sudoku
    When I successfully run `sudoku-validator ./invalid_incomplete.sudoku`
    Then the output should contain "This sudoku is invalid."
