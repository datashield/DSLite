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
#' @examples {
#'   # detect DS packages
#'   defaultDSConfiguration()
#'   # exclude a DS package
#'   defaultDSConfiguration(exclude="dsBase")
#'   # include explicitely some DS packages
#'   defaultDSConfiguration(include=c("dsBase", "dsOmics"))
#' }
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
  # all package names
  packageNames <- unique(basename(path = list.dirs(path = .libPaths(), recursive = FALSE)))

  # DataSHIELD settings from the DATASHIELD file
  dsPaths <- as.list(sapply(packageNames, function(p) { system.file("DATASHIELD", package = p) }))
  dsSettings <- lapply(dsPaths[lapply(dsPaths, nchar)>0], read.dcf)

  # init
  aggregateMethods <- list(name=c(), value=c(), package=c(), version=c())
  assignMethods <- list(name=c(), value=c(), package=c(), version=c())
  options <- list()

  appendAggregateMethods <- function(package, version, methodsStr) {
    methods <- .strToList(methodsStr, package)
    for (m in names(methods)) {
      idx <- which(aggregateMethods$name %in% m)
      if (length(idx) > 0) {
        pkg <- as.character(aggregateMethods$package[idx[1]])
        warning("Ignoring aggregate method '", m, "' from package '", as.character(package), "' because it is already defined by package '", pkg, "'!")
      } else {
        aggregateMethods$name <- append(aggregateMethods$name, m)
        aggregateMethods$value <- append(aggregateMethods$value, methods[[m]])
        aggregateMethods$package <- append(aggregateMethods$package, as.character(package))
        aggregateMethods$version <- append(aggregateMethods$version, as.character(version))
      }
    }
    aggregateMethods$type <- rep("aggregate", length(aggregateMethods$name))
    aggregateMethods$class <- rep("function", length(aggregateMethods$name))
    aggregateMethods
  }

  appendAssignMethods <- function(package, version, methodsStr) {
    methods <- .strToList(methodsStr, package)
    for (m in names(methods)) {
      idx <- which(assignMethods$name %in% m)
      if (length(idx) > 0) {
        pkg <- as.character(assignMethods$package[idx[1]])
        warning("Ignoring assign method '", m, "' from package '", as.character(package), "' because it is already defined by package '", pkg, "'!")
      } else {
        assignMethods$name <- append(assignMethods$name, m)
        assignMethods$value <- append(assignMethods$value, methods[[m]])
        assignMethods$package <- append(assignMethods$package, as.character(package))
        assignMethods$version <- append(assignMethods$version, as.character(version))
      }
    }
    assignMethods$type <- rep("assign", length(assignMethods$name))
    assignMethods$class <- rep("function", length(assignMethods$name))
    assignMethods
  }

  appendOptions <- function(opts) {
    append(options, .strToList(opts))
  }

  dsPackageNames <- names(dsSettings)
  dsLegacyPackageNames <- c("dsBase")
  if (!is.null(include)) {
    dsLegacyPackageNames <- unique(append(dsLegacyPackageNames, include))
  }
  for (pname in dsLegacyPackageNames) {
    if (pname %in% packageNames && !pname %in% dsPackageNames && isIncluded(pname) && !isExcluded(pname)) {
      # legacy
      pack <- packageDescription(pkg = pname)
      # DESCRIPTION file
      if (!is.null(pack$AggregateMethods) && !is.na(pack$AggregateMethods)) {
        aggregateMethods <- appendAggregateMethods(pack$Package, pack$Version, pack$AggregateMethods)
      }
      if (!is.null(pack$AssignMethods) && !is.na(pack$AssignMethods)) {
        assignMethods <- appendAssignMethods(pack$Package, pack$Version, pack$AssignMethods)
      }
      if (!is.null(pack$Options) && !is.na(pack$Options)) {
        options <- appendOptions(pack$Options)
      }
    }
  }
  for (pname in dsPackageNames) {
    if (isIncluded(pname) && !isExcluded(pname)) {
      pack <- packageDescription(pkg = pname)
      dsProperties <- dsSettings[[pname]]
      propNames <- dimnames(dsProperties)[[2]]
      for (i in 1:length(propNames)) {
        if (propNames[[i]] == "AggregateMethods") {
          aggregateMethods <- appendAggregateMethods(pack$Package, pack$Version, as.character(dsProperties[1,i]))
        }
        else if (propNames[[i]] == "AssignMethods") {
          assignMethods <- appendAssignMethods(pack$Package, pack$Version, as.character(dsProperties[1,i]))
        }
        else if (propNames[[i]] == "Options") {
          options <- appendOptions(as.character(dsProperties[1,i]))
        }
      }
    }
  }

  list(AggregateMethods=as.data.frame(aggregateMethods), AssignMethods=as.data.frame(assignMethods), Options=options)
}

#' Parse a key pairs string to a list
#' @keywords internal
.strToList <- function(str, pack=NULL) {
  rval <- list()
  if (!is.null(str)) {
    entries <- strsplit(gsub("[\r\n]", "", str), ",")[[1]]
    if (length(entries)>0) {
      trim <- function (x) gsub("^\\s+|\\s+$", "", x)
      for (i in 1:length(entries)) {
        if (grepl("=", entries[i])) {
          tokens <- strsplit(entries[i], "=")[[1]]
          rval[[trim(tokens[[1]])]] <- trim(tokens[[2]])
        } else if (!is.null(pack)) {
          rval[[trim(entries[i])]] <- paste0(pack, "::", trim(entries[i]))
        }
      }
    }
  }
  rval
}



