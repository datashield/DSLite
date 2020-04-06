#' Setup a test environment based on the TESTING.DATASET simulated datasets
#'
#' Load the TESTING.DATASET datasets, the corresponding login data object, instanciate a new \link{DSLiteServer}
#' hosting these datasets and verify that the required DataSHIELD server-side packages are installed.
#'
#' @param packages DataSHIELD server-side packages which local installation must be verified so that the \link{DSLiteServer}
#' can auto-configure itself and can execute the DataSHIELD operations. Default is none.
#' @param env The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
#' the DSIConnection objects. Default is the Global environment.
#' @return The login data for the \link{datashield.login} function.
#' @family setup functions
#' @examples
#' {
#' logindata <- setupDATASETTest()
#' conns <- datashield.login(logindata, assign=TRUE)
#' # do DataSHIELD analysis
#' datashield.logout(conns)
#' }
#' @export
setupDATASETTest <- function(packages = c(), env = parent.frame()) {
  setupDSLiteServer(packages, c("TESTING.DATASET1", "TESTING.DATASET2", "TESTING.DATASET3"),
                    "logindata.dslite.testing.dataset", "DSLite", "dslite.server", env)
}

