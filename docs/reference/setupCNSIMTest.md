# Setup a test environment based on the CNSIM simulated datasets

Load the CNSIM datasets, the corresponding login data object,
instanciate a new
[DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
hosting these datasets and verify that the required DataSHIELD
server-side packages are installed.

## Usage

``` r
setupCNSIMTest(packages = c(), env = parent.frame())
```

## Arguments

- packages:

  DataSHIELD server-side packages which local installation must be
  verified so that the
  [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.md)
  can auto-configure itself and can execute the DataSHIELD operations.
  Default is none.

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
[`setupDASIMTest()`](https://datashield.github.io/DSLite/reference/setupDASIMTest.md),
[`setupDATASETTest()`](https://datashield.github.io/DSLite/reference/setupDATASETTest.md),
[`setupDISCORDANTTest()`](https://datashield.github.io/DSLite/reference/setupDISCORDANTTest.md),
[`setupDSLiteServer()`](https://datashield.github.io/DSLite/reference/setupDSLiteServer.md),
[`setupSURVIVALTest()`](https://datashield.github.io/DSLite/reference/setupSURVIVALTest.md)

## Examples

``` r
if (FALSE) { # \dontrun{
logindata <- setupCNSIMTest()
conns <- datashield.login(logindata, assign=TRUE)
# do DataSHIELD analysis
datashield.logout(conns)
} # }
```
