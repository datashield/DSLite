#' Create a new DSLite server
#'
#' Shortcut function to create a new \link{DSLiteServer} instance.
#'
#' @param tables A named list of data.frames representing the harmonized tables.
#' @param config The DataSHIELD configuration. Default is to discover it from the DataSHIELD server-side R packages.
#' See \link{defaultDSConfiguration} function for including or excluding packages when discovering the DataSHIELD configuration
#' from the DataSHIELD server-side packages (meta-data from the DESCRIPTION files).
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
#' @section Methods:
#' \code{$new(tables, config, strict, home)} Create new DSLiteServer instance with the arguments described in the Fields section.
#' See \link{defaultDSConfiguration} function for including or excluding packages when discovering the DataSHIELD configuration
#' from the DataSHIELD server-side packages (meta-data from the DESCRIPTION files).
#'
#' \code{$config(value)} Get (if \code{value} argument is missing) or set the DataSHIELD configuration: aggregate/assign methods
#' in data frames and a named list of options.
#'
#' \code{$strict(value)} Get (if \code{value} argument is missing) or set the \code{strict} logical field.
#'
#' \code{$home(value)} Get (if \code{value} argument is missing) or set the \code{home} field.
#'
#' \code{$workspaces()} List all the workspaces stored in the \code{home} folder.
#'
#' \code{$workspace_save(sid, name)} Save the session's workspace image identified by the \code{sid} identifier
#'   with the provided \code{name} in the \code{home} folder.
#'
#' \code{$workspace_rm(name)} Remove the workspace image with the provided \code{name} from the \code{home} folder.
#'
#' \code{$aggregateMethods(value)} Get (if \code{value} argument is missing) or set the aggregate methods, a \code{data.frame}
#' with columns: \code{name} (the client function call), \code{value} (the translated server call), \code{package} (relevant when
#' extracted from a DataSHIELD server-side package), \code{version} (relevant when extracted from a DataSHIELD server-side package),
#' \code{type} ("aggregate"), \code{class} (always "function" as custom scripts are not supported).
#'
#' \code{$aggregateMethod(name, value)} Get (if \code{value} argument is missing) or set the aggregate method: \code{name} (the client
#' function call), \code{value} (the translated server call). Remove the method when \code{value} is \code{NULL}.
#'
#' \code{$assignMethods(value)} Get (if \code{value} argument is missing) or set the assign methods, a \code{data.frame}
#' with columns: \code{name} (the client function call), \code{value} (the translated server call), \code{package} (relevant when
#' extracted from a DataSHIELD server-side package), \code{version} (relevant when extracted from a DataSHIELD server-side package),
#' \code{type} ("aggregate"), \code{class} (always "function" as custom scripts are not supported).
#'
#' \code{$assignMethod(name, value)} Get (if \code{value} argument is missing) or set the assign method: \code{name} (the client
#' function call), \code{value} (the translated server call). Remove the method when \code{value} is \code{NULL}.
#'
#' \code{$options(value)} Get (if \code{value} argument is missing) or set the DataSHIELD R options that are applied when a new
#' DataSHIELD session is started.
#'
#' \code{$option(key, value)} Get (if \code{value} argument is missing) or set the R option. Remove the option when \code{value} is \code{NULL}.
#'
#' \code{$newSession(restore)} Create a new DataSHIELD session and restore workspace image if \code{restore} workspace name argument is provided.
#'
#' \code{$hasSession(sid)} Check a DataSHIELD session is alive.
#'
#' \code{$closeSession(sid, save)} Destroy DataSHIELD session and save workspace image if \code{save} workspace name argument is provided.
#'
#' \code{$tableNames()} List the names of the tables that can be assigned.
#'
#' \code{$hasTable(name)} Check the table exists.
#'
#' \code{$symbols(sid)} List the symbols living in the DataSHIELD session identified by \code{sid}.
#'
#' \code{$symbol_rm(sid, name)} Remove a symbol from the DataSHIELD session identified by \code{sid}.
#'
#' \code{$assignTable(sid, symbol, name, variables=NULL)} Assign a table to a symbol in the DataSHIELD session identified by \code{sid}. Filter
#' table columns with the variables names provided.
#'
#' \code{$assignExpr(sid, symbol, expr)} Evaluate an assignment expression in the DataSHIELD session identified by \code{sid}.
#'
#' \code{$aggregate(sid, expr)} Evaluate an aggregation expression in the DataSHIELD session identified by \code{sid}.
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
    },
    # get a method
    .get.method = function(methods, key) {
      if (is.null(methods) || is.null(key)) {
        NULL
      } else {
        rval <- as.character(subset(methods, name == key)$value)
        if (length(rval) == 0) {
          NULL
        } else {
          as.character(rval)
        }
      }
    },
    # set a method
    .set.method = function(methods, type, key, value) {
      if (is.null(key)) {
        methods
      } else {
        names <- names(methods)
        if (length(names) == 0) {
          names <- c("name", "value", "package", "version", "type", "class")
        }
        df <- data.frame()
        if (!is.null(methods) && "name" %in% names(methods)) {
          df <- subset(methods, name != key)
        }
        if (is.null(value)) {
          df
        } else {
          row <- list()
          for (k in names) {
            if (k == "name") {
              row[["name"]] <- key
            } else if (k == "value") {
              row[["value"]] <- value
            } else if (k == "type") {
              row[["type"]] <- type
            } else if (k == "class") {
              row[["class"]] <- "function" # no custom script support
            } else {
              row[[k]] <- NA
            }
          }
          rbind(df, as.data.frame(row))
        }
      }
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

    #
    # Workspaces
    #
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

    #
    # DataSHIELD configuration
    #
    # get or set the data.frame representing the aggregate methods
    aggregateMethods = function(value) {
      if (missing(value)) {
        private$.config$AggregateMethods
      } else {
        private$.config$AggregateMethods <- value
      }
    },
    # get or set an aggregate method
    aggregateMethod = function(name, value) {
      if (missing(value)) {
        private$.get.method(private$.config$AggregateMethods, name)
      } else {
        private$.config$AggregateMethods <- private$.set.method(private$.config$AggregateMethods, "aggregate", name, value)
        invisible(TRUE)
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
    # get or set an aggregate method
    assignMethod = function(name, value) {
      if (missing(value)) {
        private$.get.method(private$.config$AssignMethods, name)
      } else {
        private$.config$AssignMethods <- private$.set.method(private$.config$AssignMethods, "assign", name, value)
        invisible(TRUE)
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
    # get or set an option, return NULL if it does not exist
    option = function(key, value) {
      if (missing(value)) {
        if (is.null(private$.config$Options) || is.null(key)) {
          NULL
        } else {
          private$.config$Options[[key]]
        }
      } else if (is.null(key)) {
        invisible(FALSE)
      } else {
        if (is.null(private$.config$Options)) {
          private$.config$Options <- list()
        }
        private$.config$Options[[key]] <- value
        invisible(TRUE)
      }
    },

    #
    # DataSHIELD sessions
    #
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
        opts <- append(opts, paste0("datashield.wd='", wd, "'"))
        opts <- paste(opts, collapse = ",")
        opts <- paste0("options(", opts, ")")
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

    #
    # DataSHIELD operations
    #
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
