#' @include DSLiteDriver.R
setOldClass("DSLiteServer")

#' Class DSLiteConnection.
#'
#' An DSLiteServer connection implementing the DataSHIELD Interface (DSI) \code{\link{DSConnection-class}}.
#'
#' @import methods
#' @import DSI
#' @export
#' @keywords internal
setClass("DSLiteConnection", contains = "DSConnection", slots = list(name = "character", sid = "character", server = "DSLiteServer"))

#' Connect to a DSLite server
#'
#' Connect to a DSLite server, with provided datasets symbol names.
#'
#' @param drv \code{\link{DSLiteDriver-class}} class object.
#' @param name Name of the connection, which must be unique among all the DataSHIELD connections.
#' @param url A R symbol that refers to a \link{DSLiteServer} object that holds the datasets of interest. The
#' option "datashield.env" can be used to specify where to search for this symbol value. If not specified,
#' the environment is the global one.
#' @param restore Workspace name to be restored in the newly created DataSHIELD R session.
#' @param ... Unused, needed for compatibility with generic.
#'
#' @return A \code{\link{DSLiteConnection-class}} object.
#'
#' @import methods
#' @export
setMethod("dsConnect", "DSLiteDriver",
          function(drv, name, url, restore = NULL, ...) {
            # get the R symbol value
            server <- base::get(url, envir = getOption("datashield.env", globalenv()))
            if (is.null(server) || !("DSLiteServer" %in% class(server))) {
              stop(paste0("Not a valid DSLite server identified by '", url, "', expecting an object of class: DSLiteServer"))
            }
            sid <- server$newSession(restore = restore)
            con <- new("DSLiteConnection", name = name, sid = sid, server = server)
            con
          })

#' Disconnect from a DSLite server
#'
#' Save the session in a local file if requested.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#' @param save Save the DataSHIELD R session with provided ID (must be a character string).
#'
#' @import methods
#' @export
setMethod("dsDisconnect", "DSLiteConnection", function(conn, save = NULL) {
  conn@server$closeSession(conn@sid, save = save)
  invisible(TRUE)
})

#' List DSLite server datasets
#'
#' List dataset names living in the DSLite server for performing DataSHIELD operations.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#'
#' @return The fully qualified names of the tables.
#'
#' @import methods
#' @export
setMethod("dsListTables", "DSLiteConnection", function(conn) {
  conn@server$tableNames()
})

#' Verify DSLite server dataset
#'
#' Verify dataset exists and can be accessible for performing DataSHIELD operations.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object.
#' @param table The fully qualified name of the dataset.
#'
#' @return TRUE if dataset exists.
#'
#' @import methods
#' @export
setMethod("dsHasTable", "DSLiteConnection", function(conn, table) {
  conn@server$hasTable(table)
})

#' DSLite asynchronous support
#'
#' No asynchronicity on any DataSHIELD operations.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#'
#' @return The named list of logicals detailing the asynchronicity support.
#'
#' @import methods
#' @export
setMethod("dsIsAsync", "DSLiteConnection", function(conn) {
  list(aggregate = FALSE, assignTable = FALSE, assignExpr = FALSE)
})

#' List R symbols
#'
#' List symbols living in the DataSHIELD R session.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#'
#' @return A character vector.
#'
#' @import methods
#' @export
setMethod("dsListSymbols", "DSLiteConnection", function(conn) {
  conn@server$symbols(conn@sid)
})

#' Remove a R symbol
#'
#' Remoe a symbol living in the DataSHIELD R session.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#' @param symbol Name of the R symbol.
#'
#' @import methods
#' @export
setMethod("dsRmSymbol", "DSLiteConnection", function(conn, symbol) {
  conn@server$symbol_rm(conn@sid, symbol)
})

#' List methods
#'
#' List methods defined in the DataSHIELD configuration.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#' @param type Type of the method: "aggregate" (default) or "assign".
#'
#' @return A data frame.
#'
#' @import methods
#' @export
setMethod("dsListMethods", "DSLiteConnection", function(conn, type = "aggregate") {
  if (type == "aggregate") {
    conn@server$aggregateMethods()
  } else {
    conn@server$assignMethods()
  }
})

#' List packages
#'
#' List packages defined in the DataSHIELD configuration.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#'
#' @return A data frame.
#'
#' @import methods
#' @export
setMethod("dsListPackages", "DSLiteConnection", function(conn) {
  methods <- rbind(dsListMethods(conn, type = "aggregate"), dsListMethods(conn, type = "assign"))
  unique(as.data.frame(list(package=methods$package, version=methods$version)))
})


#' List workspaces
#'
#' List workspaces saved in the data repository.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#'
#' @return A data frame.
#'
#' @import methods
#' @export
setMethod("dsListWorkspaces", "DSLiteConnection", function(conn) {
  conn@server$workspaces(paste0(conn@name, ":"))
})

#' Save workspace
#'
#' Save workspace on the data repository.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#' @param name Name of the workspace.
#'
#' @import methods
#' @export
setMethod("dsSaveWorkspace", "DSLiteConnection", function(conn, name) {
  conn@server$workspace_save(conn@sid, name)
})

#' Remove a workspace
#'
#' Remove a workspace on the data repository.
#'
#' @param conn \code{\link{DSLiteConnection-class}} class object
#' @param name Name of the workspace.
#'
#' @import methods
#' @export
setMethod("dsRmWorkspace", "DSLiteConnection", function(conn, name) {
  conn@server$workspace_rm(name)
})

#' Assign a table
#'
#' Assign a DSLite dataset in the DataSHIELD R session.
#'
#' @param conn \code{\link{DSLiteConnection-class}} object.
#' @param symbol Name of the R symbol.
#' @param table Fully qualified name of a dataset living in the DSLite server.
#' @param variables List of variable names or Javascript expression that selects the variables of a table (ignored if value does not refere to a table). See javascript documentation: http://wiki.obiba.org/display/OPALDOC/Variable+Methods
#' @param missings If TRUE, missing values will be pushed from Opal to R, default is FALSE. Ignored if value is an R expression.
#' @param identifiers Name of the identifiers mapping to use when assigning entities to R (currently NOT supported by DSLite).
#' @param id.name Name of the column that will contain the entity identifiers. If not specified, the identifiers
#'   will be the data frame row names. When specified this column can be used to perform joins between data frames.
#' @param async Whether the result of the call should be retrieved asynchronously. When TRUE (default) the calls are parallelized over
#'   the connections, when the connection supports that feature, with an extra overhead of requests.
#'
#' @return A \code{\link{DSLiteResult-class}} object.
#'
#' @import methods
#' @export
setMethod("dsAssignTable", "DSLiteConnection", function(conn, symbol, table, variables=NULL, missings=FALSE, identifiers=NULL, id.name=NULL, async=TRUE) {
  rval <- FALSE
  if (conn@server$hasTable(table)) {
    if (!is.null(identifiers) && identifiers != "") {
      warning("Identifiers mapping is currently not supported by DSLite")
    }
    conn@server$assignTable(conn@sid, symbol, table, variables=variables, id.name=id.name)
    rval <- TRUE
  }
  new("DSLiteResult", conn = conn, rval = list(status = ifelse(rval, "COMPLETED", "FAILED"), result = NULL))
})
#' Assign the result of an expression
#'
#' Assign a result of the execution of an expression in the DataSHIELD R session.
#'
#' @param conn \code{\link{DSLiteConnection-class}} object.
#' @param symbol Name of the R symbol.
#' @param expr A R expression with allowed assign functions calls.
#' @param async Whether the result of the call should be retrieved asynchronously. When TRUE (default) the calls are parallelized over
#'   the connections, when the connection supports that feature, with an extra overhead of requests.
#'
#' @return A \code{\link{DSLiteResult-class}} object.
#'
#' @import methods
#' @export
setMethod("dsAssignExpr", "DSLiteConnection", function(conn, symbol, expr, async=TRUE) {
  rval <- conn@server$assignExpr(conn@sid, symbol, expr)
  new("DSLiteResult", conn = conn, rval = list(status = "COMPLETED", result = NULL))
})

#' Aggregate data
#'
#' Aggregate some data from the DataSHIELD R session using a valid R expression. The aggregation expression
#' must satisfy the data repository's DataSHIELD configuration.
#'
#' @param conn \code{\link{DSLiteConnection-class}} object.
#' @param expr Expression to evaluate.
#' @param async Whether the result of the call should be retrieved asynchronously. When TRUE (default) the calls are parallelized over
#'   the connections, when the connection supports that feature, with an extra overhead of requests.
#'
#' @import methods
#' @export
setMethod("dsAggregate", "DSLiteConnection", function(conn, expr, async=TRUE) {
  rval <- conn@server$aggregate(conn@sid, expr)
  new("DSLiteResult", conn = conn, rval = list(status="COMPLETED", result = rval))
})
