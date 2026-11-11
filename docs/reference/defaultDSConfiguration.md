# Default DataSHIELD configuration

Find the R packages that have DataSHIELD server configuration
information in them and extract this information in a data frame of
aggregation/assignment methods and a named list of R options. The
DataSHIELD packages can be filtered by specifying explicitly the package
names to be included or excluded. The package exclusion prevails over
the inclusion.

## Usage

``` r
defaultDSConfiguration(include = NULL, exclude = NULL)
```

## Arguments

- include:

  Character vector of package names to be explicitly included. If NULL,
  do not filter packages.

- exclude:

  Character vector of package names to be explicitly excluded. If NULL,
  do not filter packages.

## Examples

``` r
if (FALSE) { # \dontrun{
# detect DS packages
defaultDSConfiguration()
# exclude a DS package
defaultDSConfiguration(exclude="dsBase")
# include explicitely some DS packages
defaultDSConfiguration(include=c("dsBase", "dsOmics"))
} # }
```
