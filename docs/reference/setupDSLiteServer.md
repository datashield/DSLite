# Setup an environment based on named datasets and logindata

Load the provided datasets and the corresponding logindata object,
instanciate a new
[DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
hosting these datasets, verifies that the required DataSHIELD
server-side packages are installed. All the data structures are loaded
by [data](https://rdrr.io/r/utils/data.html) which supports various
formats (see data() documentation).

## Usage

``` r
setupDSLiteServer(
  packages = c(),
  datasets,
  logindata,
  pkgs = NULL,
  dslite.server = NULL,
  env = parent.frame()
)
```

## Arguments

- packages:

  DataSHIELD server-side packages which local installation must be
  verified so that the
  [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
  can auto-configure itself and can execute the DataSHIELD operations.
  Default is none.

- datasets:

  Names of the datasets to be loaded using
  [data](https://rdrr.io/r/utils/data.html).

- logindata:

  Name of the login data object to be loaded using
  [data](https://rdrr.io/r/utils/data.html).

- pkgs:

  The package(s) to look in for datasets, default is all, then the
  'data' subdirectory (if present) of the current working directory
  (same behavior as 'package' argument in
  [data](https://rdrr.io/r/utils/data.html)).

- dslite.server:

  Symbol name to which the
  [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
  should be assigned to. If not provided, the symbol name will be the
  first not null one specified in the 'url' column of the loaded login
  data.

- env:

  The environment where DataSHIELD objects should be looked for: the
  [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
  and the DSIConnection objects. Default is the Global environment.

## Value

The login data for the
[datashield.login](https://datashield.github.io/DSI/reference/datashield.login.html)
function.

## See also

Other setup functions:
[`setupCNSIMTest()`](https://datashield.github.io/DSLite/reference/setupCNSIMTest.md),
[`setupDASIMTest()`](https://datashield.github.io/DSLite/reference/setupDASIMTest.md),
[`setupDATASETTest()`](https://datashield.github.io/DSLite/reference/setupDATASETTest.md),
[`setupDISCORDANTTest()`](https://datashield.github.io/DSLite/reference/setupDISCORDANTTest.md),
[`setupSURVIVALTest()`](https://datashield.github.io/DSLite/reference/setupSURVIVALTest.md)

## Examples

``` r
if (FALSE) { # \dontrun{
logindata <- setupDSLiteServer(
                 datasets = c("CNSIM1", "CNSIM2", "CNSIM3"),
                 logindata = "logindata.dslite.cnsim", pkgs = "DSLite",
                 dslite.server = "dslite.server")
conns <- datashield.login(logindata, assign=TRUE)
# do DataSHIELD analysis
datashield.logout(conns)
} # }
```
