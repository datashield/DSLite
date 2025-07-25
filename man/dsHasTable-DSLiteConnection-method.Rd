% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DSLiteConnection.R
\name{dsHasTable,DSLiteConnection-method}
\alias{dsHasTable,DSLiteConnection-method}
\title{Verify DSLite server dataset}
\usage{
\S4method{dsHasTable}{DSLiteConnection}(conn, table)
}
\arguments{
\item{conn}{\code{\linkS4class{DSLiteConnection}} class object.}

\item{table}{The fully qualified name of the dataset.}
}
\value{
TRUE if dataset exists.
}
\description{
Verify dataset exists and can be accessible for performing DataSHIELD operations.
}
