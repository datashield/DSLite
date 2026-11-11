# List profiles

List profiles defined in the DataSHIELD configuration.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsListProfiles(conn)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  class object

## Value

A list containing the "available" character vector of profile names and
the "current" profile (in case a default one was assigned).
