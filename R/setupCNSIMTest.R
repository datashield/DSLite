#' Setup a test environment based on the CNSIM simulated datasets
#'
#' Load the CNSIM datasets and the corresponding loadingdata object, instanciate a new \link{DSLiteServer}
#' hosting these datasets, verifies that the required DataSHIELD server-side packages are installed.
#'
#' @param packages DataSHIELD server-side packages that must be installed locally so that the \link{DSLiteServer}
#' can execute the DataSHIELD operations.
#' @param env The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
#' the DSIConnection objects. Default is the Global environment.
#' @return The login data for the \link{datashield.login} function.
#' @family setup functions
#' @export
setupCNSIMTest <- function(packages, env = globalenv()) {
  setupDSLiteServer(packages, c("CNSIM1", "CNSIM2", "CNSIM3"),
                    "logindata.dslite.cnsim", "DSLite", "dslite.server", env)
}

