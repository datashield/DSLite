% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setupDATASETTest.R
\name{setupDATASETTest}
\alias{setupDATASETTest}
\title{Setup a test environment based on the TESTING.DATASET simulated datasets}
\usage{
setupDATASETTest(packages = c(), env = parent.frame())
}
\arguments{
\item{packages}{DataSHIELD server-side packages which local installation must be verified so that the \link{DSLiteServer}
can auto-configure itself and can execute the DataSHIELD operations. Default is none.}

\item{env}{The environment where DataSHIELD objects should be looked for: the \link{DSLiteServer} and
the DSIConnection objects. Default is the Global environment.}
}
\value{
The login data for the \link[DSI]{datashield.login} function.
}
\description{
Load the TESTING.DATASET datasets, the corresponding login data object, instanciate a new \link{DSLiteServer}
hosting these datasets and verify that the required DataSHIELD server-side packages are installed.
}
\examples{
\dontrun{
logindata <- setupDATASETTest()
conns <- datashield.login(logindata, assign=TRUE)
# do DataSHIELD analysis
datashield.logout(conns)
}
}
\seealso{
Other setup functions: 
\code{\link{setupCNSIMTest}()},
\code{\link{setupDASIMTest}()},
\code{\link{setupDISCORDANTTest}()},
\code{\link{setupDSLiteServer}()},
\code{\link{setupSURVIVALTest}()}
}
\concept{setup functions}
