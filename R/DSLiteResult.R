#' @include DSLiteDriver.R DSLiteConnection.R
NULL

#' Class DSLiteResult.
#'
#' An DSLite result implementing the DataSHIELD Interface (DSI) \code{\link{DSResult-class}}.
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
#' @param dsObj \code{\link{DSLiteResult-class}} class object
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
#' @param res \code{\link{DSLiteResult-class}} object.
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
#' @param res \code{\link{DSLiteResult-class}} object.
#'
#' @return TRUE if table exists.
#'
#' @import methods
#' @export
setMethod("dsFetch", "DSLiteResult", function(res) {
  res@rval$result
})

