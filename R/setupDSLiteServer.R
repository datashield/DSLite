#' Setup an environment based on named datasets and logindata
#'
#' Load the provided datasets and the corresponding logindata object, instanciate a new \link{DSLiteServer}
#' hosting these datasets, verifies that the required DataSHIELD server-side packages are installed.
#' All the data structures are loaded by \link{data} which supports various formats (see data() documentation).
#'
#' @param packages DataSHIELD server-side packages that must be installed locally so that the \link{DSLiteServer}
#' can execute the DataSHIELD operations.
#' @param datasets Names of the datasets to be loaded using \link{data}.
#' @param logindata Name of the login data object to be loaded using \link{data}.
#' @param pkgs The package(s) to look in for datasets, default is all.
#' @param dslite.server Symbol name to which the \link{DSLiteServer} should be assigned to.
#' @param env The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
#' the DSIConnection objects. Default is the Global environment.
#' @return The login data for the \link{datashield.login} function.
#' @family setup functions
#' @export
setupDSLiteServer <- function(packages, datasets, logindata, pkgs = NULL, dslite.server="dslite.server", env = globalenv()) {
  # check server-side package is installed
  for (package in packages) {
    if (!base::requireNamespace(package, quietly = TRUE)) {
      stop(package, " package is required in the local R installation for the execution of the tests.",
           call. = FALSE)
    }
  }

  # load simulated test datasets and corresponding login definition
  data(list = datasets, package = pkgs, envir = env)
  data(list = logindata, package = pkgs, envir = env)

  # new DSLiteServer, hosting the simulated test datasets
  tables <- list()
  for (dataset in datasets) {
    tables[[dataset]] <- get(dataset, envir = env)
  }
  assign(dslite.server, newDSLiteServer(tables=tables), envir = env)
  # specify in which environment the dslite server lives
  options(datashield.env=env)

  # return logindata
  get(logindata, envir = env)
}
