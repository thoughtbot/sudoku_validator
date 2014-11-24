Command line utility that validates the proper format of a an arbitrary sized Sedoku.

Sedoku must be a text file in the format of the test/files.  Spaces separate all numbers, new lines separate all rows.

The results returns 'Valid' when valid.

When doubles are found, it returns the Columns, rows and quadrants that caused the problem.

Quadrants are labeled from top left to bottom right, so a 2 by 2 grid would be
 1 2
 3 4

Columns are labeled left to right.

Rows are labeled top to bottom.

So

Invalid: Quadrant 5 has 3 3's and Column 9 has 2 2's

Means the middle 5th quadrant and the 9th column are the reason it is not valid.

To execute run
  ruby