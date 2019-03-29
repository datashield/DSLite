#' Setup a test environment based on the CNSIM simulated datasets
#'
#' Load the CNSIM datasets, instanciate a new \link{DSLiteServer} hosting these datasets, verifies that
#' the required DataSHIELD server-side packages are installed.
#'
#' @param packages DataSHIELD server-side packages that must be installed locally so that the \link{DSLiteServer}
#' can execute the DataSHIELD operations.
#' @param env The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
#' the DSIConnection objects.
#' @return The login data for the \link{datashield.login} function.
#' @family test setup
#' @export
setupCNSIMTest <- function(packages, env) {
  # check server-side package is installed
  for (package in packages) {
    if (!base::requireNamespace(package, quietly = TRUE)) {
      stop(package, " package is required in the local R installation for the execution of the tests.",
           call. = FALSE)
    }
  }

  # needed so that code check does not get confused
  CNSIM1 <- NULL
  CNSIM2 <- NULL
  CNSIM3 <- NULL

  # load simulated test datasets and corresponding login definition
  data("CNSIM1", envir = env)
  data("CNSIM2", envir = env)
  data("CNSIM3", envir = env)
  data("logindata.dslite.cnsim", envir = env)

  # new DSLiteServer, hosting the simulated test datasets
  dslite.server <- newDSLiteServer(tables=list(CNSIM1=get("CNSIM1", envir = env),
                                               CNSIM2=get("CNSIM2", envir = env),
                                               CNSIM3=get("CNSIM3", envir = env)))
  assign("dslite.server", dslite.server, envir = env)
  # specify in which environment the dslite server lives
  options(datashield.env=env)

  get("logindata.dslite.cnsim", envir = env)
}
