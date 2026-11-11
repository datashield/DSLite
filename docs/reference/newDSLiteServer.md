# Create a new DSLite server

Shortcut function to create a new `DSLiteServer` instance.

## Usage

``` r
newDSLiteServer(
  tables = list(),
  resources = list(),
  config = DSLite::defaultDSConfiguration(),
  strict = TRUE,
  home = file.path(tempdir(), ".dslite")
)
```

## Arguments

- tables:

  A named list of data.frames representing the harmonized tables.

- resources:

  A named list of `resourcer::Resource` objects representing accessible
  data or computation resources.

- config:

  The DataSHIELD configuration. Default is to discover it from the
  DataSHIELD server-side R packages. See
  [defaultDSConfiguration](https://datashield.github.io/DSLite/reference/defaultDSConfiguration.md)
  function for including or excluding packages when discovering the
  DataSHIELD configuration from the DataSHIELD server-side packages
  (meta-data from the DESCRIPTION files).

- strict:

  Logical to specify whether the DataSHIELD configuration must be
  strictly applied. Default is TRUE.

- home:

  Folder location where are located the session work directory and where
  to read and dump workspace images. Default is in a hidden folder of
  the R session's temporary directory.

## See also

Other server-side items:
[`DSLiteServer`](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
