#' Setup an environment based on named datasets and logindata
#'
#' Load the provided datasets and the corresponding logindata object, instanciate a new \link{DSLiteServer}
#' hosting these datasets, verifies that the required DataSHIELD server-side packages are installed.
#' All the data structures are loaded by \link{data} which supports various formats (see data() documentation).
#'
#' @param packages DataSHIELD server-side packages which local installation must be verified so that the \link{DSLiteServer}
#' can auto-configure itself and can execute the DataSHIELD operations. Default is none.
#' @param datasets Names of the datasets to be loaded using \link{data}.
#' @param logindata Name of the login data object to be loaded using \link{data}.
#' @param pkgs The package(s) to look in for datasets, default is all, then the 'data' subdirectory (if present)
#' of the current working directory (same behavior as 'package' argument in \link{data}).
#' @param dslite.server Symbol name to which the \link{DSLiteServer} should be assigned to. If not provided, the symbol name
#' will be the first not null one specified in the 'url' column of the loaded login data.
#' @param env The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
#' the DSIConnection objects. Default is the Global environment.
#' @return The login data for the \link{datashield.login} function.
#' @family setup functions
#'
#' @examples
#' \dontrun{
#' logindata <- setupDSLiteServer(
#'                  datasets = c("CNSIM1", "CNSIM2", "CNSIM3"),
#'                  logindata = "logindata.dslite.cnsim", pkgs = "DSLite",
#'                  dslite.server = "dslite.server")
#' conns <- datashield.login(logindata, assign=TRUE)
#' # do DataSHIELD analysis
#' datashield.logout(conns)
#' }
#'
#' @export
setupDSLiteServer <- function(packages = c(), datasets, logindata, pkgs = NULL, dslite.server = NULL, env = parent.frame()) {
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

  # get server symbol from login data if not provided by argument
  dslite.server.sym <- dslite.server
  if (is.null(dslite.server)) {
    ld <- get(logindata, envir = env)
    dslite.server.sym <- as.character(ld[!is.null(ld$url),][1,]$url)
  }

  assign(dslite.server, newDSLiteServer(tables=tables), envir = env)
  # specify in which environment the dslite server lives
  options(datashield.env=env)

  # return logindata
  get(logindata, envir = env)
}
