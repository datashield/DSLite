# Assign a resource

Assign a DSLite resource in the DataSHIELD R session.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsAssignResource(conn, symbol, resource, async = TRUE)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  object.

- symbol:

  Name of the R symbol.

- resource:

  Fully qualified name of a resource object living in the DSLite server.

- async:

  Whether the result of the call should be retrieved asynchronously.
  When TRUE (default) the calls are parallelized over the connections,
  when the connection supports that feature, with an extra overhead of
  requests.

## Value

A
[`DSLiteResult`](https://datashield.github.io/DSLite/reference/DSLiteResult-class.md)
object.
