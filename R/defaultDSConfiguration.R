#' Default DataSHIELD configuration
#'
#' Find the R packages that have DataSHIELD server configuration information in them
#' and extract this information in a data frame of aggregation/assignment methods and a named list
#' of R options. The DataSHIELD packages can be filtered by specifying explicitly the package names
#' to be included or excluded. The package exclusion prevails over the inclusion.
#'
#' @param include Character vector of package names to be explicitly included. If NULL, do not filter packages.
#' @param exclude Character vector of package names to be explicitly excluded. If NULL, do not filter packages.
#'
#' @import utils
#' @export
defaultDSConfiguration <- function(include=NULL, exclude=NULL) {
  # filter functions
  isIncluded <- function(name) {
    if (is.null(include)) {
      TRUE
    } else {
      name %in% include
    }
  }
  isExcluded <- function(name) {
    if (is.null(exclude)) {
      FALSE
    } else {
      name %in% exclude
    }
  }

  fields <- c("Package", "Version", "AggregateMethods", "AssignMethods", "Options")
  packs <- as.data.frame(utils::installed.packages(fields = fields))
  dsPacks <- subset(packs, !is.na(packs$AggregateMethods) | !is.na(packs$AssignMethods) | !is.na(packs$Options))
  aggregateMethods <- list(name=c(), value=c(), package=c(), version=c())
  assignMethods <- list()
  options <- list()

  print(dsPacks)

  if (nrow(dsPacks)>0) {
    for (i in 1:nrow(dsPacks)) {
      pack <- dsPacks[i,]
      if (isIncluded(pack$Package) && !isExcluded(pack$Package)) {
        if (!is.na(pack$AggregateMethods)) {
          methods <- .strToList(pack$AggregateMethods, pack$Package)
          for (m in names(methods)) {
            aggregateMethods$name <- append(aggregateMethods$name, m)
            aggregateMethods$value <- append(aggregateMethods$value, methods[[m]])
            aggregateMethods$package <- append(aggregateMethods$package, as.character(pack$Package))
            aggregateMethods$version <- append(aggregateMethods$version, as.character(pack$Version))
          }
          aggregateMethods$type <- rep("aggregate", length(aggregateMethods$name))
          aggregateMethods$class <- rep("function", length(aggregateMethods$name))
        }
        if (!is.na(pack$AssignMethods)) {
          methods <- .strToList(pack$AssignMethods, pack$Package)
          for (m in names(methods)) {
            assignMethods$name <- append(assignMethods$name, m)
            assignMethods$value <- append(assignMethods$value, methods[[m]])
            assignMethods$package <- append(assignMethods$package, as.character(pack$Package))
            assignMethods$version <- append(assignMethods$version, as.character(pack$Version))
          }
          assignMethods$type <- rep("assign", length(assignMethods$name))
          assignMethods$class <- rep("function", length(assignMethods$name))
        }
        if (!is.na(pack$Options)) {
          opts <- .strToList(pack$Options)
          options <- append(options, opts)
        }
      }
    }
  }
  list(AggregateMethods=as.data.frame(aggregateMethods), AssignMethods=as.data.frame(assignMethods), Options=options)
}

#' Parse a key pairs string to a list
#' @keywords internal
.strToList <- function(str, pack=NULL) {
  entries <- strsplit(gsub("[\r\n]", "", str), ",")[[1]]
  rval <- list()
  trim <- function (x) gsub("^\\s+|\\s+$", "", x)
  for (i in 1:length(entries)) {
    if (grepl("=", entries[i])) {
      tokens <- strsplit(entries[i], "=")[[1]]
      rval[[trim(tokens[[1]])]] <- trim(tokens[[2]])
    } else if (!is.null(pack)) {
      rval[[trim(entries[i])]] <- paste0(pack, "::", trim(entries[i]))
    }
  }
  rval
}



