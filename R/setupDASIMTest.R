#' Setup a test environment based on the DASIM simulated datasets
#'
#' Load the DASIM datasets, the corresponding login data object, instanciate a new \link{DSLiteServer}
#' hosting these datasets and verify that the required DataSHIELD server-side packages are installed.
#'
#' @param packages DataSHIELD server-side packages which local installation must be verified so that the \link{DSLiteServer}
#' can auto-configure itself and can execute the DataSHIELD operations. Default is none.
#' @param env The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
#' the DSIConnection objects. Default is the Global environment.
#' @return The login data for the \link[DSI]{datashield.login} function.
#' @family setup functions
#' @examples
#' \dontrun{
#' logindata <- setupDASIMTest()
#' conns <- datashield.login(logindata, assign=TRUE)
#' # do DataSHIELD analysis
#' datashield.logout(conns)
#' }
#' @export
setupDASIMTest <- function(packages = c(), env = parent.frame()) {
  setupDSLiteServer(packages, c("DASIM1", "DASIM2", "DASIM3"),
                    "logindata.dslite.dasim", "DSLite", "dslite.server", env)
}

