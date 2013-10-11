# Sudoku Validator
**An excercise for Prime Subscribers. Visit http://learn.thoughtbot.com/prime to
learn more.**

Dificulty: **Advanced Beginner**

## Your Task
[Sudoku](http://en.wikipedia.org/wiki/Sudoku) is a logic-based combinatorial number-placement puzzle. The objective is
to fill a 9×9 grid with digits so that each column, each row, and each of the
nine 3×3 sub-grids that compose the grid contains all of the digits from 1 to 9.

Write a command-line program that can read a file containing a sudoku grid and
validates it. The grid can be partially or completely solved. It either gives a
success message or a list of errors and
their positions.

Sample usage:

```
$ sudoku-validator ./valid_complete.sudoku
  This sudoku is valid.

$ sudoku-validator ./valid_incomplete.sudoku
  This sudoku is valid, but incomplete.

$ sudoku-validator ./invalid_complete.sudoku
  This sudoku is invalid.

$ sudoku-validator ./invalid_incomplete.sudoku
  This sudoku is invalid.
```

A sudoku is valid if:
* it has no duplicates in a row
* it has no duplicates in a column
* it has no duplicates in a sub-grid

## Input files
The input files look like this

```
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
```

There are four sample sudoku files in this repo that you can use as input/test
fixtures. They cover the permutations of valid/invalid and complete/incomplete

## Working/Submitting
1. To work on this exercise, fork the repo and begin implementing your solution.
2. Your solution must be tested, preferably via TDD.
3. Create a pull request so your code can be reviewed.
4. Perform a code review on at least one other person's solution. Your comments
   should follow our code review guidelines:
https://github.com/thoughtbot/guides/tree/master/code-review. Most important: be
friendly. Make suggestions, not demands.
5. Improve your solution based on the comments you've received and approaches
   you've learned from reviewing others' attempts.
