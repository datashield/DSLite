# Connect to a DSLite server

Connect to a DSLite server, with provided datasets symbol names.

## Usage

``` r
# S4 method for class 'DSLiteDriver'
dsConnect(drv, name, url, restore = NULL, profile = NULL, ...)
```

## Arguments

- drv:

  [`DSLiteDriver`](https://datashield.github.io/DSLite/reference/DSLiteDriver-class.md)
  class object.

- name:

  Name of the connection, which must be unique among all the DataSHIELD
  connections.

- url:

  A R symbol that refers to a
  [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
  object that holds the datasets of interest. The option
  "datashield.env" can be used to specify where to search for this
  symbol value. If not specified, the environment is the global one.

- restore:

  Workspace name to be restored in the newly created DataSHIELD R
  session.

- profile:

  Name of the profile that will be given to the DSLiteServer
  configuration. Make different DSLiteServers to support different
  configurations.

- ...:

  Unused, needed for compatibility with generic.

## Value

A
[`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md)
object.
