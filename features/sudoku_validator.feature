Feature: sudoku-validator
  Scenario: validate something
    Given a file named "invalid_complete.sudoku" with:
      """
      8 5 9 |6 1 2 |4 3 7
      7 2 3 |8 5 4 |1 6 9
      1 6 4 |3 7 9 |5 2 8
      ------+------+------
      9 8 6 |1 4 7 |3 5 2
      3 7 5 |8 6 2 |9 1 4
      2 4 1 |5 9 3 |7 8 6
      ------+------+------
      4 3 2 |9 8 1 |6 7 5
      6 1 7 |4 2 5 |8 9 3
      5 9 8 |7 3 6 |2 4 1
      """
    When I run `sudoku-validator invalid_complete.sudoku`
    Then it should pass with:
      """
      This sudoku is invalid.
      """

  Scenario: validate something
    Given a file named "invalid_incomplete.sudoku" with:
      """
      8 5 . |. . 2 |4 . .
      7 2 . |. 8 . |. . 9
      . . 4 |. . . |. . .
      ------+------+------
      . . . |1 . 7 |. . 2
      3 . 5 |. . . |9 . .
      . 4 . |. . . |. . .
      ------+------+------
      . 5 . |. 8 . |. 7 .
      . 1 7 |. . . |. . .
      . . . |. 3 6 |. 4 .
      """
    When I run `sudoku-validator invalid_incomplete.sudoku`
    Then it should pass with:
      """
      This sudoku is invalid.
      """

  Scenario: validate something
    Given a file named "valid_complete.sudoku" with:
      """
      8 5 9 |6 1 2 |4 3 7
      7 2 3 |8 5 4 |1 6 9
      1 6 4 |3 7 9 |5 2 8
      ------+------+------
      9 8 6 |1 4 7 |3 5 2
      3 7 5 |2 6 8 |9 1 4
      2 4 1 |5 9 3 |7 8 6
      ------+------+------
      4 3 2 |9 8 1 |6 7 5
      6 1 7 |4 2 5 |8 9 3
      5 9 8 |7 3 6 |2 4 1
      """
    When I run `sudoku-validator valid_complete.sudoku`
    Then it should pass with:
      """
      This sudoku is valid.
      """

  Scenario: validate something
    Given a file named "valid_complete.sudoku" with:
      """
      8 5 . |. . 2 |4 . .
      7 2 . |. . . |. . 9
      . . 4 |. . . |. . .
      ------+------+------
      . . . |1 . 7 |. . 2
      3 . 5 |. . . |9 . .
      . 4 . |. . . |. . .
      ------+------+------
      . . . |. 8 . |. 7 .
      . 1 7 |. . . |. . .
      . . . |. 3 6 |. 4 .
      """
    When I run `sudoku-validator valid_complete.sudoku`
    Then it should pass with:
      """
      This sudoku is valid, but incomplete.
      """
