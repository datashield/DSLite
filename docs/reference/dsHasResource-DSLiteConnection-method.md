# Verify DSLite server resource

Verify resource exists and can be accessible for performing DataSHIELD
operations.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsHasResource(conn, resource)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  class object.

- resource:

  The fully qualified name of the resource.

## Value

TRUE if dataset exists.
