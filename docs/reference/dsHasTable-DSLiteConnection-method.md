# Verify DSLite server dataset

Verify dataset exists and can be accessible for performing DataSHIELD
operations.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsHasTable(conn, table)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  class object.

- table:

  The fully qualified name of the dataset.

## Value

TRUE if dataset exists.
