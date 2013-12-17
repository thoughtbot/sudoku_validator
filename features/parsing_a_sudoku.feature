Feature: parsing a sudoku

  Scenario: valid & complete
    When I run `./sudoku-validator valid_complete.sudoku`
    Then the stdout should contain "This sudoku is valid."

  Scenario: valid & incomplete
    When I run `./sudoku-validator valid_incomplete.sudoku`
    Then the stdout should contain "This sudoku is valid, but incomplete."

  Scenario: invalid & complete
    When I run `./sudoku-validator invalid_complete.sudoku`
    Then the stdout should contain "This sudoku is invalid."
    And the stdout should contain "#4 contains duplicate 8s"
    And the stdout should contain "#6 contains duplicate 2s"

  Scenario: invalid & incomplete
    When I run `./sudoku-validator invalid_incomplete.sudoku`
    Then the stdout should contain "This sudoku is invalid."
    And the stdout should contain "#2 contains duplicate 5s"
    And the stdout should contain "#5 contains duplicate 8s"
