# Get data value from DSLite connection(s)

Get the data value corresponding to the variable with the symbol name
from the
[DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
associated to the
[`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
object(s). Can be useful when developping a DataSHIELD package.

## Usage

``` r
getDSLiteData(conns, symbol)
```

## Arguments

- conns:

  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)
  object or a list of
  [`DSConnection-class`](https://datashield.github.io/DSI/reference/DSConnection-class.html)s.

- symbol:

  Symbol name identifying the variable in the
  [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)'s
  "server-side" environment(s).

## Value

The data value or a list of values depending on the connections
parameter. The value is NA when the connection object is not of class
[`DSLiteConnection`](https://datashield.github.io/DSLite/reference/DSLiteConnection-class.md).

## Examples

``` r
if (FALSE) { # \dontrun{
# DataSHIELD login
logindata <- setupCNSIMTest()
conns <- datashield.login(logindata, assign=TRUE)
# retrieve symbol D value from each DataSHIELD connections
getDSLiteData(conns, "D")
# retrieve symbol D value from a specific DataSHIELD connection
getDSLiteData(conns$sim1, "D")
} # }
```
