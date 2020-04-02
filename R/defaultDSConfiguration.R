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

  #
  # DataSHIELD settings from the DATASHIELD file
  #
  dsPaths <- lapply(installed.packages()[,1], function(p) { system.file('DATASHIELD', package=p) })
  dsSettings <- lapply(dsPaths[lapply(dsPaths, nchar)>0], read.dcf)

  #
  # DataSHIELD settings from the DESCRIPTION file
  #
  fields <- c("Package", "Version", "AggregateMethods", "AssignMethods", "Options")
  packs <- as.data.frame(utils::installed.packages(fields = fields))
  dsPacks <- subset(packs, (isIncluded(packs$Package) & !isExcluded(packs$Package))
                    & (!is.na(packs$AggregateMethods) | !is.na(packs$AssignMethods) | !is.na(packs$Options)
                       | as.character(packs$Package) %in% names(dsSettings)))
  aggregateMethods <- list(name=c(), value=c(), package=c(), version=c())
  assignMethods <- list(name=c(), value=c(), package=c(), version=c())
  options <- list()

  appendAggregateMethods <- function(package, version, methodsStr) {
    methods <- .strToList(pack$AggregateMethods, pack$Package)
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

  if (nrow(dsPacks)>0) {
    for (i in 1:nrow(dsPacks)) {
      pack <- dsPacks[i,]
      # DESCRIPTION file
      if (!is.na(pack$AggregateMethods)) {
        aggregateMethods <- appendAggregateMethods(pack$Package, pack$Version, pack$AggregateMethods)
      }
      if (!is.na(pack$AssignMethods)) {
        assignMethods <- appendAssignMethods(pack$Package, pack$Version, pack$AssignMethods)
      }
      if (!is.na(pack$Options)) {
        options <- appendOptions(pack$Options)
      }
      # DATASHIELD file
      pname <- as.character(pack$Package)
      if (pname %in% names(dsSettings)) {
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



