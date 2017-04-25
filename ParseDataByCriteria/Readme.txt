Readme for ParseDataByCriteria
==============================

ParseDataByCriteria.m is the 'primary' script; this uses the other two .m files as functions.

Two sets of examples are provided. Load any of the two sets and run `ParseDataByCriteria.m`. The results that should be obtained are saved in the corresponding `_Results.mat` files.

Note that in the two examples, the 'colnames' variable contains the same column names, only in different order, and this determines the sequence of values in the output variables.

Feel free to play around with other column names for `colnames`. Only, note that the first column in `DRData` (Column name = `ID` in `DRCols`) is a `unique` field, i.e. it has a unique value for each row. Using this as a column name in `colnames` is not a good idea, as the program will not be able to find *any* common values to sort into, leading to extremely large output variables.