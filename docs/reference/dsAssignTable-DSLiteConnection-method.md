# Assign a table

Assign a DSLite dataset in the DataSHIELD R session.

## Usage

``` r
# S4 method for class 'DSLiteConnection'
dsAssignTable(
  conn,
  symbol,
  table,
  variables = NULL,
  missings = FALSE,
  identifiers = NULL,
  id.name = NULL,
  async = TRUE
)
```

## Arguments

- conn:

  [`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
  object.

- symbol:

  Name of the R symbol.

- table:

  Fully qualified name of a dataset living in the DSLite server.

- variables:

  The variable names to be filtered in.

- missings:

  Ignored.

- identifiers:

  Name of the identifiers mapping to use when assigning entities to R
  (currently NOT supported by DSLite).

- id.name:

  Name of the column that will contain the entity identifiers. If not
  specified, the identifiers will be the data frame row names. When
  specified this column can be used to perform joins between data
  frames.

- async:

  Whether the result of the call should be retrieved asynchronously.
  When TRUE (default) the calls are parallelized over the connections,
  when the connection supports that feature, with an extra overhead of
  requests.

## Value

A
[`DSLiteResult`](https://datashield.github.io/DSLite/reference/DSLiteResult-class.md)
object.
