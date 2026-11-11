# Assign the result of an expression

Assign a result of the execution of an expression in the DataSHIELD R
session.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsAssignExpr(conn, symbol, expr, async = TRUE)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  object.

- symbol:

  Name of the R symbol.

- expr:

  A R expression with allowed assign functions calls.

- async:

  Whether the result of the call should be retrieved asynchronously.
  When TRUE (default) the calls are parallelized over the connections,
  when the connection supports that feature, with an extra overhead of
  requests.

## Value

A
[`DSLiteResult`](https://datashield.github.io/DSLite/reference/DSLiteResult-class.md)
object.
