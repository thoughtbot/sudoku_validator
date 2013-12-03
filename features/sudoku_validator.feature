Feature: Validating .sudoku files

  Scenario: A valid, complete sudoku
    When I successfully run `sudoku-validator ./valid_complete.sudoku`
    Then the output should contain "This sudoku is valid."
