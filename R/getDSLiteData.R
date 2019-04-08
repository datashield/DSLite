#' Get data value from DSLite connection(s)
#'
#' Get the data value corresponding to the variable with the symbol name from the \link{DSLiteServer} associated
#' to the \code{\link{DSConnection-class}} object(s). Can be useful when developping a DataSHIELD package.
#'
#' @param conns \code{\link{DSConnection-class}} object or a list of \code{\link{DSConnection-class}}s.
#' @param symbol Symbol name identifying the variable in the \link{DSLiteServer}'s "server-side" environment(s).
#' @return The data value or a list of values depending on the connections parameter. The value is NA when the connection object
#' is not of class \code{\link{DSLiteConnection-class}}.
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
