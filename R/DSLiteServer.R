#' Create a new DSLite server
#'
#' Shortcut function to create a new \code{DSLiteServer} instance.
#'
#' @param tables A named list of data.frames representing the harmonized tables.
#' @param resources A named list of \code{resourcer::Resource} objects representing accessible data or computation resources.
#' @param config The DataSHIELD configuration. Default is to discover it from the DataSHIELD server-side R packages.
#' See \link{defaultDSConfiguration} function for including or excluding packages when discovering the DataSHIELD configuration
#' from the DataSHIELD server-side packages (meta-data from the DESCRIPTION files).
#' @param strict Logical to specify whether the DataSHIELD configuration must be strictly applied. Default is TRUE.
#' @param home Folder location where are located the session work directory and where to read and dump workspace images.
#' Default is in a hidden folder of the user home.
#'
#' @family server-side items
#' @export
newDSLiteServer <- function(tables = list(), resources = list(), config = DSLite::defaultDSConfiguration(), strict = TRUE, home = file.path("~", ".dslite")) {
  DSLiteServer$new(tables = tables, resources = resources, config = config, strict = strict, home = home)
}

#' @title Lightweight DataSHIELD server-side component
#'
#' @description DSLiteServer mimics a DataSHIELD server by holding datasets and exposing
#' DataSHIELD-like functions: aggregate and assign. A DataSHIELD session is a R
#' environment where the assignment and the operations happen.
#'
#' @family server-side items
#' @docType class
#' @import R6
#' @export
DSLiteServer <- R6::R6Class(
  "DSLiteServer",
  public = list(

    #' @description Create new DSLiteServer instance. See \link{defaultDSConfiguration} function for including or excluding packages
    #' when discovering the DataSHIELD configuration from the DataSHIELD server-side packages (meta-data from the DESCRIPTION files).
    #' @param tables A named list of data.frames representing the harmonized tables.
    #' @param resources A named list of \code{resourcer::Resource} objects representing accessible data or computation resources.
    #' @param config The DataSHIELD configuration. Default is to discover it from the DataSHIELD server-side R packages.
    #' @param strict Logical to specify whether the DataSHIELD configuration must be strictly applied. Default is TRUE.
    #' @param home Folder location where are located the session work directory and where to read and dump workspace images.
    #' Default is in a hidden folder of the user home.
    #' @return A DSLiteServer object
    initialize = function(tables = list(), resources = list(), config = DSLite::defaultDSConfiguration(), strict = TRUE, home = file.path("~", ".dslite")) {
      private$.tables <- tables
      private$.resources <- resources
      private$.config <- config
      private$.strict <- strict
      private$.home <- home
      private$.home.mkdir()
    },

    #' @description Get or set the DataSHIELD configuration.
    #' @param value The DataSHIELD configuration: aggregate/assign methods in data frames and a named list of options.
    #' @return The DataSHIELD configuration, if no parameter is provided.
    config = function(value) {
      if (missing(value)) {
        private$.config
      } else {
        private$.config <- value
      }
    },

    #' @description Get or set the level of strictness (stop when function call is not configured)
    #' @param value The \code{strict} logical field.
    #' @return The strict field if no parameter is provided.
    strict = function(value) {
      if (missing(value)) {
        private$.strict
      } else {
        private$.strict <- value
      }
    },

    #' @description Get or set the home folder location where are located the session work directories and where to read and dump workspace images.
    #' @param value The path to the home folder.
    #' @return The home folder path if no parameter is provided.
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

    #' @description List the saved workspaces in the \code{home} folder.
    #' @param prefix Filter workspaces starting with provided prefix (optional).
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

    #' @description Save the session's workspace image identified by the \code{sid} identifier
    #'   with the provided \code{name} in the \code{home} folder.
    #' @param sid, Session ID
    #' @param name The name to be given to the workspace's image.
    workspace_save = function(sid, name) {
      ws <- private$.as.ws.path(name)
      if (dir.exists(ws)) {
        unlink(ws, recursive = TRUE)
      }
      path <- private$.as.ws.image.path(name)
      # save working directory content
      wd <- private$.as.wd.path(sid)
      origwd <- setwd(wd)
      on.exit(setwd(origwd))
      tryCatch(file.copy(from = list.files(wd), to = ws, recursive = TRUE, copy.mode = TRUE))
      # save environment image
      env <- private$.sessions[[sid]]
      save(list = ls(all.names = TRUE, envir = env), file=path, envir = env)
    },

    #' @description Remove the workspace image with the provided \code{name} from the \code{home} folder.
    #' @param name The name of the workspace.
    workspace_rm = function(name) {
      path <- private$.as.ws.path(name)
      unlink(path, recursive = TRUE)
    },

    #
    # DataSHIELD configuration
    #

    #' @description Get or set the aggregate methods.
    #' @param value A \code{data.frame} with columns: \code{name} (the client function call),
    #' \code{value} (the translated server call), \code{package} (relevant when extracted from a DataSHIELD server-side package),
    #' \code{version} (relevant when extracted from a DataSHIELD server-side package), \code{type} ("aggregate"),
    #' \code{class} ("function" for package functions or "script" for custom scripts).
    #' @return The aggregate methods when no parameter is provided.
    aggregateMethods = function(value) {
      if (missing(value)) {
        private$.config$AggregateMethods
      } else {
        private$.config$AggregateMethods <- value
      }
    },

    #' @description Get or set an aggregate method.
    #' @param name The client function call.
    #' @param value The translated server call: either a package function reference or function expression. Remove the method when \code{NULL}.
    #' @return The aggregate method when no \code{value} parameter is provided.
    aggregateMethod = function(name, value) {
      if (missing(value)) {
        private$.get.method(private$.config$AggregateMethods, name)
      } else {
        private$.config$AggregateMethods <- private$.set.method(private$.config$AggregateMethods, "aggregate", name, value)
        invisible(TRUE)
      }
    },

    #' @description Get or set the assign methods.
    #' @param value A \code{data.frame} with columns: \code{name} (the client function call), \code{value} (the translated server call),
    #' \code{package} (relevant when extracted from a DataSHIELD server-side package), \code{version} (relevant when extracted from a DataSHIELD server-side package),
    #' \code{type} ("assign"), \code{class} ("function" for package functions or "script" for custom scripts).
    #' @return The assign methods when no parameter is provided.
    assignMethods = function(value) {
      if (missing(value)) {
        private$.config$AssignMethods
      } else {
        private$.config$AssignMethods <- value
      }
    },

    #' @description Get or set an assign method.
    #' @param name The client function call
    #' @param value The translated server call: either a package function reference or function expression. Remove the method when \code{NULL}.
    #' @return The assign method when no \code{value} parameter is provided.
    assignMethod = function(name, value) {
      if (missing(value)) {
        private$.get.method(private$.config$AssignMethods, name)
      } else {
        private$.config$AssignMethods <- private$.set.method(private$.config$AssignMethods, "assign", name, value)
        invisible(TRUE)
      }
    },

    #' @description Get or set the DataSHIELD R options that are applied when a new DataSHIELD session is started.
    #' @param value A named list of options.
    #' @return The R options when no parameter is provided.
    options = function(value) {
      if (missing(value)) {
        private$.config$Options
      } else {
        private$.config$Options <- value
      }
    },

    #' @description Get or set a R option.
    #' @param key The R option's name.
    #' @param value The R option's value. Remove the option when \code{NULL}.
    #' @return The R option's value when only \code{key} parameter is provided.
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

    #' @description Create a new DataSHIELD session (contained execution environment) and restore workspace image
    #' if \code{restore} workspace name argument is provided.
    #' @param restore The workspace image to be restored (optional).
    newSession = function(restore = NULL) {
      sid <- as.character(sample(1000:9999, 1))
      env <- new.env()
      parent.env(env) <- parent.env(globalenv())
      private$.sessions[[sid]] <- env
      wd <- private$.as.wd.path(sid)
      # prepare options
      if (!is.null(private$.config$Options)) {
        opts <- lapply(names(private$.config$Options), function(opt) { paste0(opt, "=", private$.config$Options[[opt]]) })
        if (length(opts)>0) {
          opts <- paste(opts, collapse = ",")
          opts <- paste0("options(", opts, ")")
          eval(parse(text = opts), envir = private$.sessions[[sid]])
        }
        if (!("datashield.seed") %in% names(private$.config$Options)) {
          opt <- getOption("datashield.seed", 1234)
          eval(parse(text = paste0("options(datashield.seed=",opt,")")), envir = private$.sessions[[sid]])
        }
      }
      # restore workspace
      if (!is.null(restore)) {
        # restore image
        path <- private$.as.ws.image.path(restore)
        if (file.exists(path)) {
          load(path, envir = private$.sessions[[sid]])
        }
        # restore files
        ws <- private$.as.ws.path(restore)
        files <- list.files(ws)
        files <- files[files != ".RData"]
        if (length(files)>0) {
          files <- unlist(lapply(files, function(f) { file.path(ws, f) }))
          file.copy(from = files, to = wd, recursive = TRUE, copy.mode = TRUE)
        }
      }
      sid
    },

    #' @description Check a DataSHIELD session is alive.
    #' @param sid The session ID.
    hasSession = function(sid) {
      sid %in% names(private$.sessions)
    },

    #' @description Get the DataSHIELD session's environment.
    #' @param sid The session ID.
    getSession = function(sid) {
      private$.sessions[[sid]]
    },

    #' @description Get the DataSHIELD session IDs.
    getSessionIds = function() {
      names(private$.sessions)
    },

    #' @description Get the symbol value from the DataSHIELD session's environment.
    #' @param sid The session ID.
    #' @param symbol The symbol name.
    getSessionData = function(sid, symbol) {
      base::get(symbol, envir = private$.sessions[[sid]])
    },

    #' @description Destroy DataSHIELD session and save workspace image if \code{save} workspace name argument is provided.
    #' @param sid The session ID.
    #' @param save The name of the workspace image to be saved (optional).
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

    #' @description List the names of the tables that can be assigned.
    tableNames = function() {
      names(private$.tables)
    },

    #' @description Check a table exists.
    #' @param name The table name to be looked for.
    hasTable = function(name) {
      name %in% names(private$.tables)
    },

    #' @description List the names of the resources (\code{resourcer::Resource} objects) that can be assigned.
    resourceNames = function() {
      names(private$.resources)
    },

    #' @description Check a resource (\code{resourcer::Resource} object) exists.
    #' @param name The resource name to be looked for.
    hasResource = function(name) {
      name %in% names(private$.resources)
    },

    #' @description List the symbols living in a DataSHIELD session.
    #' @param sid The session ID.
    symbols = function(sid) {
      ls(envir = private$.session(sid))
    },

    #' @description Remove a symbol from a DataSHIELD session.
    #' @param sid The session ID.
    #' @param name The symbol name.
    symbol_rm = function(sid, name) {
      invisible(rm(list=c(name), envir = private$.session(sid)))
    },

    #' @description Assign a table to a symbol in a DataSHIELD session. Filter
    #' table columns with the variables names provided.
    #' @param sid The session ID.
    #' @param symbol The symbol to be assigned.
    #' @param name The table's name.
    #' @param variables The variable names to be filtered in (optional).
    #' @param id.name The column name to be used for the entity's identifier (optional).
    assignTable = function(sid, symbol, name, variables=NULL, id.name=NULL) {
      df <- private$.tables[[name]]
      if (!is.null(variables)) {
        vars <- variables
        if (is.list(variables)) {
          vars <- unlist(variables)
        }
        if (is.character(vars)) {
          # make sure variables specified are existing column names
          cols <- colnames(df)
          vars <- vars[sapply(vars, function(v) v %in% cols)]
          df <- subset(df, select = vars)
        }
      }
      if (!is.null(id.name) && id.name != "" && !(id.name %in% colnames(df))) {
        df[id.name] <- row.names(df)
      }
      if (getOption("dslite.verbose", FALSE)) {
        message(paste0("Symbol to assign: ", symbol))
      }
      assign(symbol, df, envir = private$.session(sid))
    },

    #' @description Assign a resource as a \code{resourcer::ResourceClient} object to a symbol in a DataSHIELD session.
    #' @param sid The session ID.
    #' @param symbol The symbol name.
    #' @param name The name of the resource.
    assignResource = function(sid, symbol, name) {
      res <- private$.resources[[name]]
      if (getOption("dslite.verbose", FALSE)) {
        message(paste0("Symbol to assign: ", symbol))
      }
      assign(symbol, resourcer::newResourceClient(res), envir = private$.session(sid))
    },

    #' @description Evaluate an assignment expression in a DataSHIELD session.
    #' @param sid The session ID.
    #' @param symbol The symbol name.
    #' @param expr The R expression to evaluate.
    assignExpr = function(sid, symbol, expr) {
      exprr <- private$.as.language(sid, expr, private$.config$AssignMethods)
      origwd <- setwd(private$.get.wd(sid))
      on.exit(setwd(origwd))
      if (getOption("dslite.verbose", FALSE)) {
        message(paste0("Symbol to assign: ", symbol))
      }
      tryCatch(assign(symbol, eval(exprr, envir = private$.session(sid)), envir = private$.session(sid)))
    },

    #' @description Evaluate an aggregate expression in a DataSHIELD session.
    #' @param sid The session ID.
    #' @param expr The R expression to evaluate.
    aggregate = function(sid, expr) {
      exprr <- private$.as.language(sid, expr, private$.config$AggregateMethods)
      origwd <- setwd(private$.get.wd(sid))
      on.exit(setwd(origwd))
      tryCatch(eval(exprr, envir = private$.session(sid)))
    }
  ),

  private = list(
    # data frames representing the harmonized tables
    .tables = NULL,
    # ResourceClient objects representing accessible data or computation resources
    .resources = NULL,
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
    .as.language = function(sid, expr, methods) {
      if (is.null(expr)) {
        stop("Invalid expression type: 'NULL'. Expected a call or character vector.",
             call. = FALSE)
      }
      exprStr <- expr
      # handle expressions made with quote() or call()
      if (is.language(expr)) {
        exprStr <- deparse(expr)
        if(length(exprStr) > 1) {
          exprStr = paste(exprStr, collapse='\n')
        }
      }

      # find replacement method
      replaceMethod <- function(name) {
        found <- methods[methods$name == name,]
        if (nrow(found) == 0) {
          NA
        } else {
          valueStr <- as.character(found$value)
          if (found$class == "script") {
            # case inlined function: assign function to a symbol in session's environment
            assign(name, eval(str2lang(valueStr)), envir = private$.session(sid))
            name
          } else {
            # case already defined function (in a package most likely)
            valueStr
          }
        }
      }

      if (!is.null(methods)) {
        # develop function calls according to configured methods
        parseExpr <- parse(text = exprStr, keep.source = TRUE)
        parseData <- utils::getParseData(parseExpr)
        if (getOption("dslite.debug", FALSE)) {
          print(parseData)
        }
        parseData <- parseData[parseData$token != "expr",]

        for (i in 1:length(parseData$token)) {
          if (parseData[i,]$token == "SYMBOL_FUNCTION_CALL") {
            method <- parseData[i,]$text
            replacement <- replaceMethod(method)
            if (getOption("dslite.debug", FALSE)) {
              message("Replacement of '", method, "': '", replacement, "' (is.na=", is.na(replacement), ")")
            }
            if (!is.na(replacement)) {
              parseData[i,]$text <- replacement
            } else if (private$.strict) {
              if (is.null(methods) || length(methods) == 0) {
                stop(paste0("DataSHIELD configuration does not allow expression: ", method,
                            "\nNo DataSHIELD methods have been configured (No DataSHIELD server-side package is installed)."),
                     call. = FALSE)
              } else {
                stop(paste0("DataSHIELD configuration does not allow expression: ", method,
                            "\nSupported function calls are: ", paste0(methods$name, collapse = ", ")),
                     call. = FALSE)
              }
            }
          }
        }
        # text may be truncated
        exprStr <- paste(unlist(lapply(rownames(parseData), function(id) utils::getParseText(parseData, id))), collapse = "")
      }
      if (getOption("dslite.verbose", FALSE)) {
        message(paste0("Expression to evaluate: ", exprStr))
      }
      parse(text=exprStr)
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
          valueStr <- value
          if (is.function(value)) {
            valueStr <- paste0(deparse(value), collapse = "\n")
          }
          for (k in names) {
            if (k == "name") {
              row[["name"]] <- key
            } else if (k == "value") {
              row[["value"]] <- valueStr
            } else if (k == "type") {
              row[["type"]] <- type
            } else if (k == "class") {
              if (is.function(value)) {
                row[["class"]] <- "script"
              } else {
                row[["class"]] <- "function"
              }
            } else {
              row[[k]] <- NA
            }
          }
          rbind(df, as.data.frame(row))
        }
      }
    },
    # get working directory corresponding to the session
    .get.wd = function(sid) {
      private$.as.wd.path(sid)
    }
  )
)
