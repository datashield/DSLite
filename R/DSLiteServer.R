#' Create a new DSLite server
#'
#' Shortcut function to create a new \link{DSLiteServer} instance.
#'
#' @param tables A named list of data.frames representing the harmonized tables.
#' @param config The DataSHIELD configuration. Default is to discover it from the DataSHIELD server-side R packages.
#' @param strict Logical to specify whether the DataSHIELD configuration must be strictly applied. Default is TRUE.
#'
#' @family server-side items
#' @export
newDSLiteServer <- function(tables = list(), config = DSLite::defaultDSConfiguration(), strict = TRUE) {
  DSLiteServer$new(tables = tables, config = config, strict = strict)
}

#' Lightweight DataSHIELD server-side component
#'
#' DSLiteServer mimics a DataSHIELD server by holding datasets and exposing
#' DataSHIELD-like functions: aggregate and assign. A DataSHIELD session is a R
#' environment where the assignment and the operations happen.
#'
#' @field tables A named list of data.frames representing the harmonized tables.
#' @field config The DataSHIELD configuration. Default is to discover it from the DataSHIELD server-side R packages.
#' @field strict Logical to specify whether the DataSHIELD configuration must be strictly applied. Default is TRUE.
#'
#' @family server-side items
#' @docType class
#' @import R6
#' @export
DSLiteServer <- R6::R6Class(
  "DSLiteServer",
  private = list(
    # data frames representing the harmonized tables
    .tables = NULL,
    # DataSHIELD configuration: aggregate/assign methods and options
    .config = NULL,
    # if TRUE, stop when function call is not one of the configured ones
    .strict = TRUE,
    # active DataSHIELD sessions (contained execution environments)
    .sessions = list(),
    # get a session
    .session = function(sid) {
      private$.sessions[[sid]]
    },
    # apply configuration to function calls in the expression
    .as.language = function(expr, methods) {
      expression <- expr
      # handle expressions made with quote() or call()
      if (is.language(expr)) {
        expression <- deparse(expr)
        if(length(expression) > 1) {
          expression = paste(expression, collapse='\n')
        }
      }
      normalized <- FALSE
      if (!is.null(methods)) {
        # develop function calls according to configured methods
        for (i in 1:length(methods$name)) {
          m <- methods[i,]
          normalizedExpr <- gsub(paste0("^", m$name, "\\("), paste0(m$value, "\\("), expression)
          if (normalizedExpr != expression) {
            normalized <- TRUE
            expression <- normalizedExpr
          }
        }
      } else {
        # no configured methods = allow any
        normalized <- TRUE
      }
      if (private$.strict &&!normalized) {
        stop(paste0("DataSHIELD configuration does not allow expression: ", expression, "\nSupported function calls are: ", paste0(methods$name, collapse = ", ")))
      }
      if (getOption("dslite.verbose", FALSE)) {
        message(paste0("Expression to evaluate: ", expression))
      }
      parse(text=expression)
    }
  ),
  public = list(
    initialize = function(tables = list(), config = DSLite::defaultDSConfiguration(), strict = TRUE) {
      private$.tables <- tables
      private$.config <- config
      private$.strict <- strict
    },
    # get or set the configuration
    config = function(value) {
      if (missing(value)) {
        private$.config
      } else {
        private$.config <- value
      }
    },
    # get or set the level of strictness (stop when function call is not configured)
    strict = function(value) {
      if (missing(value)) {
        private$.strict
      } else {
        private$.strict <- value
      }
    },
    # get or set the data.frame representing the aggregate methods
    aggregateMethods = function(value) {
      if (missing(value)) {
        private$.config$AggregateMethods
      } else {
        private$.config$AggregateMethods <- value
      }
    },
    # get or set the data.frame representing the assign methods
    assignMethods = function(value) {
      if (missing(value)) {
        private$.config$AssignMethods
      } else {
        private$.config$AssignMethods <- value
      }
    },
    # get or set the named list of options
    options = function(value) {
      if (missing(value)) {
        private$.config$Options
      } else {
        private$.config$Options <- value
      }
    },
    # create a new DataSHIELD session (contained execution environment)
    newSession = function() {
      sid <- as.character(sample(1000:9999, 1))
      private$.sessions[[sid]] <- new.env()
      # prepare options
      if (!is.null(private$.config$Options)) {
        opts <- lapply(names(private$.config$Options), function(opt) { paste0(opt, "=", private$.config$Options[[opt]]) })
        opts <- paste(opts, collapse = ",")
        opts <- paste0("options(", opts, ")")
        eval(parse(text = opts), envir = private$.sessions[[sid]])
      }
      sid
    },
    # check a DataSHIELD session exists
    hasSession = function(sid) {
      sid %in% names(private$.sessions)
    },
    # close a DataSHIELD session
    closeSession = function(sid) {
      private$.sessions[[sid]] <- NULL
    },
    # list tables hold by the server
    tableNames = function() {
      names(private$.tables)
    },
    # check server has a table
    hasTable = function(name) {
      name %in% names(private$.tables)
    },
    # list the symbols in the DataSHIELD session
    symbols = function(sid) {
      base::ls(envir = private$.session(sid))
    },
    # remove a symbol from the DataSHIELD session
    symbol_rm = function(sid, name) {
      invisible(base::rm(list=c(name), envir = private$.session(sid)))
    },
    # apply table assignment operation in the DataSHIELD session
    assignTable = function(sid, symbol, name, variables=NULL) {
      df <- private$.tables[[name]]
      if (is.character(variables)) {
        df <- df[, colnames(df) %in% variables]
      }
      base::assign(symbol, df, envir = private$.session(sid))
    },
    # apply expression assignement operation in the DataSHIELD session
    assignExpr = function(sid, symbol, expr) {
      exprr <- private$.as.language(expr, private$.config$AssignMethods)
      base::assign(symbol, eval(exprr, envir = private$.session(sid)), envir = private$.session(sid))
    },
    # apply aggregate operation in the DataSHIELD session
    aggregate = function(sid, expr) {
      exprr <- private$.as.language(expr, private$.config$AggregateMethods)
      eval(exprr, envir = private$.session(sid))
    }
  )
)
