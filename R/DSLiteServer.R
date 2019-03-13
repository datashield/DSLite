#' Create a new DSLite server
#'
#' Shortcut function to create a new \link{DSLiteServer} instance.
#'
#' @param tables A named list of data.frames representing the harmonized tables.
#' @param config The DataSHIELD configuration. Default is to discover it from the DataSHIELD server-side R packages.
#' @param strict Logical to specify whether the DataSHIELD configuration must be strictly applied. Default is TRUE.
#' @param home Folder location where are located the session work directory and where to read and dump workspace images.
#' Default is in a hidden folder of the user home.
#'
#' @family server-side items
#' @export
newDSLiteServer <- function(tables = list(), config = DSLite::defaultDSConfiguration(), strict = TRUE, home = file.path("~", ".dslite")) {
  DSLiteServer$new(tables = tables, config = config, strict = strict, home = home)
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
#' @field home Folder location where are located the session work directory and where to read and dump workspace images.
#' Default is in a hidden folder of the user home.
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
    # home folder
    .home = NULL,
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
    },
    # ensure home dir is defined and exists
    .home.mkdir = function() {
      if (is.null(private$.home)) {
        private$.home <- "."
      } else if (!dir.exists(private$.home)) {
        dir.create(private$.home, recursive = TRUE)
      }
    },
    # makes a session working directory path and ensure it exists
    .as.wd.path = function(sid) {
      private$.home.mkdir()
      dir <- file.path(private$.home, "sessions", sid)
      if (!dir.exists(dir)) {
        dir.create(dir, recursive = TRUE)
      }
      dir
    },
    # makes a single workspace directory path and ensure it exists
    .as.ws.path = function(name) {
      private$.home.mkdir()
      dir <- file.path(private$.home, "workspaces", name)
      if (!dir.exists(dir)) {
        dir.create(dir, recursive = TRUE)
      }
      dir
    },
    # get the path to a single workspace image
    .as.ws.image.path = function(name) {
      file.path(private$.as.ws.path(name), ".RData")
    }
  ),
  public = list(
    initialize = function(tables = list(), config = DSLite::defaultDSConfiguration(), strict = TRUE, home = file.path("~", ".dslite")) {
      private$.tables <- tables
      private$.config <- config
      private$.strict <- strict
      private$.home <- home
      private$.home.mkdir()
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
    # get or set the home folder location
    home = function(value) {
      if (missing(value)) {
        private$.home
      } else {
        private$.home <- value
        private$.home.mkdir()
      }
    },

    # list the saved workspaces
    workspaces = function(prefix = NULL) {
      private$.home.mkdir()
      path <- file.path(private$.home, "workspaces")
      name <- c()
      size <- c()
      user <- c()
      lastAccessDate <- c()
      if (dir.exists(path)) {
        dirs <- list.dirs(path, full.names = FALSE)
        for (dir in dirs) {
          if (dir != "") {
            data <- file.path(private$.home, "workspaces", dir, ".RData")
            if (file.exists(data) && (is.null(prefix) || startsWith(dir, prefix))) {
              name <- append(name, dir)
              info <- file.info(data)
              size <- append(size, info$size)
              user <- append(user, info$uname)
              lastAccessDate <- append(lastAccessDate, format(info$atime, format = "%FT%T%z"))
            }
          }
        }
      }
      data.frame(name=name, user=user, lastAccessDate=lastAccessDate, size=size)
    },
    # save a session's workspace
    workspace_save = function(sid, name) {
      path <- private$.as.ws.image.path(name)
      env <- private$.sessions[[sid]]
      save(list = ls(all.names = TRUE, envir = env), file=path, envir = env)
    },
    # save a session's workspace
    workspace_rm = function(name) {
      path <- private$.as.ws.path(name)
      unlink(path, recursive = TRUE)
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
    newSession = function(restore = NULL) {
      sid <- as.character(sample(1000:9999, 1))
      env <- new.env()
      parent.env(env) <- parent.env(globalenv())
      private$.sessions[[sid]] <- env
      wd <- private$.as.wd.path(sid)
      # prepare options
      if (!is.null(private$.config$Options)) {
        opts <- lapply(names(private$.config$Options), function(opt) { paste0(opt, "=", private$.config$Options[[opt]]) })
        opts <- paste(opts, collapse = ",")
        opts <- paste0("options(", opts, ", datashield.wd='", wd, "')")
        eval(parse(text = opts), envir = private$.sessions[[sid]])
      }
      # restore image
      if (!is.null(restore)) {
        path <- private$.as.ws.image.path(restore)
        if (file.exists(path)) {
          load(path, envir = private$.sessions[[sid]])
        }
      }
      sid
    },
    # check a DataSHIELD session exists
    hasSession = function(sid) {
      sid %in% names(private$.sessions)
    },
    # close a DataSHIELD session and save image if a name is provided
    closeSession = function(sid, save = NULL) {
      # save workspace image
      if (!is.null(save)) {
        self$workspace_rm(save)
        self$workspace_save(sid, save)
      }
      # remove working dir
      wd <- private$.as.wd.path(sid)
      if (dir.exists(wd)) {
        unlink(wd, recursive = TRUE)
      }
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
      ls(envir = private$.session(sid))
    },
    # remove a symbol from the DataSHIELD session
    symbol_rm = function(sid, name) {
      invisible(rm(list=c(name), envir = private$.session(sid)))
    },
    # apply table assignment operation in the DataSHIELD session
    assignTable = function(sid, symbol, name, variables=NULL) {
      df <- private$.tables[[name]]
      if (is.character(variables)) {
        df <- df[, colnames(df) %in% variables]
      }
      assign(symbol, df, envir = private$.session(sid))
    },
    # apply expression assignement operation in the DataSHIELD session
    assignExpr = function(sid, symbol, expr) {
      exprr <- private$.as.language(expr, private$.config$AssignMethods)
      assign(symbol, eval(exprr, envir = private$.session(sid)), envir = private$.session(sid))
    },
    # apply aggregate operation in the DataSHIELD session
    aggregate = function(sid, expr) {
      exprr <- private$.as.language(expr, private$.config$AggregateMethods)
      eval(exprr, envir = private$.session(sid))
    }
  )
)
