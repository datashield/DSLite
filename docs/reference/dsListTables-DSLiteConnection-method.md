# List DSLite server datasets

List dataset names living in the DSLite server for performing DataSHIELD
operations.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsListTables(conn)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  class object

## Value

The fully qualified names of the tables.
