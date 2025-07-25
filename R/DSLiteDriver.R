
#' Class DSLiteDriver with constructor DSLite.
#'
#' An DSLite driver implementing the DataSHIELD Interface (DSI) \code{\link[DSI]{DSDriver-class}}.
#' This class should always be initialized with the \code{\link{DSLite}} function.
#' It returns a singleton that allows you to connect to DSlite.
#'
#' @import methods
#' @import DSI
#' @export
#' @keywords internal
setClass("DSLiteDriver", contains = "DSDriver")

#' Create a DSLite driver
#'
#' Convenient function for creating a DSLiteDriver object.
#'
#' @import methods
#' @import DSI
#' @export
DSLite <- function() {
  new("DSLiteDriver")
}
