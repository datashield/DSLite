# Disconnect from a DSLite server

Save the session in a local file if requested.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsDisconnect(conn, save = NULL)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  class object

- save:

  Save the DataSHIELD R session with provided ID (must be a character
  string).
