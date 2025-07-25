#' @include DSLiteDriver.R DSLiteConnection.R
NULL

#' Class DSLiteResult.
#'
#' An DSLite result implementing the DataSHIELD Interface (DSI) \code{\link[DSI]{DSResult-class}}.
#'
#' @import methods
#' @import DSI
#' @export
#' @keywords internal
setClass("DSLiteResult", contains = "DSResult", slots = list(
  conn = "DSLiteConnection",
  rval = "list"))

#' Get result info
#'
#' Get the information about a command (if still available).
#'
#' @param dsObj \code{\linkS4class{DSLiteResult}} class object
#' @param ... Unused, needed for compatibility with generic.
#'
#' @return The result information, including its status.
#'
#' @import methods
#' @export
setMethod("dsGetInfo", "DSLiteResult", function(dsObj, ...) {
  list(status=dsObj@rval$status)
})

#' Get whether the operation is completed
#' 
#' Always TRUE because of synchronous operations.
#' 
#' @param res \code{\linkS4class{DSLiteResult}} object.
#' 
#' @return Always TRUE.
#' 
#' @import methods
#' @export
setMethod("dsIsCompleted", "DSLiteResult", function(res) {
  TRUE
})

#' Fetch the result
#'
#' Fetch the DataSHIELD operation result.
#'
#' @param res \code{\linkS4class{DSLiteResult}} object.
#'
#' @return TRUE if table exists.
#'
#' @import methods
#' @export
setMethod("dsFetch", "DSLiteResult", function(res) {
  res@rval$result
})

