% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setupDASIMTest.R
\name{setupDASIMTest}
\alias{setupDASIMTest}
\title{Setup a test environment based on the DASIM simulated datasets}
\usage{
setupDASIMTest(packages = c(), env = parent.frame())
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
Load the DASIM datasets, the corresponding login data object, instanciate a new \link{DSLiteServer}
hosting these datasets and verify that the required DataSHIELD server-side packages are installed.
}
\examples{
\dontrun{
logindata <- setupDASIMTest()
conns <- datashield.login(logindata, assign=TRUE)
# do DataSHIELD analysis
datashield.logout(conns)
}
}
\seealso{
Other setup functions: 
\code{\link{setupCNSIMTest}()},
\code{\link{setupDATASETTest}()},
\code{\link{setupDISCORDANTTest}()},
\code{\link{setupDSLiteServer}()},
\code{\link{setupSURVIVALTest}()}
}
\concept{setup functions}
