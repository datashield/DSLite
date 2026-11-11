# Aggregate data

Aggregate some data from the DataSHIELD R session using a valid R
expression. The aggregation expression must satisfy the data
repository's DataSHIELD configuration.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsAggregate(conn, expr, async = TRUE)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  object.

- expr:

  Expression to evaluate.

- async:

  Whether the result of the call should be retrieved asynchronously.
  When TRUE (default) the calls are parallelized over the connections,
  when the connection supports that feature, with an extra overhead of
  requests.
