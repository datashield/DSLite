#' Get data value from DSLite connection(s)
#'
#' Get the data value corresponding to the variable with the symbol name from the \link{DSLiteServer} associated
#' to the \code{\link[DSI]{DSConnection-class}} object(s). Can be useful when developping a DataSHIELD package.
#'
#' @param conns \code{\link[DSI]{DSConnection-class}} object or a list of \code{\link[DSI]{DSConnection-class}}s.
#' @param symbol Symbol name identifying the variable in the \link{DSLiteServer}'s "server-side" environment(s).
#' @return The data value or a list of values depending on the connections parameter. The value is NA when the connection object
#' is not of class \code{\linkS4class{DSLiteConnection}}.
#'
#' @examples
#' \dontrun{
#' # DataSHIELD login
#' logindata <- setupCNSIMTest()
#' conns <- datashield.login(logindata, assign=TRUE)
#' # retrieve symbol D value from each DataSHIELD connections
#' getDSLiteData(conns, "D")
#' # retrieve symbol D value from a specific DataSHIELD connection
#' getDSLiteData(conns$sim1, "D")
#' }
#'
#' @export
getDSLiteData <- function(conns, symbol) {
  if (is.list(conns)) {
    lapply(conns, function(conn) getDSLiteData(conn, symbol))
  } else {
    if ("DSLiteConnection" %in% class(conns)) {
      conns@server$getSessionData(conns@sid, symbol)
    } else {
      NA
    }
  }
}
