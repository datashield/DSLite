# DataSHIELD Lite

[![Build Status](https://travis-ci.com/datashield/DSLite.svg?branch=master)](https://travis-ci.com/datashield/DSLite)

Server-less [DataSHIELD Interface (DSI)](https://github.com/datashield/DSI/) implementation which purpose is to mimic
the behavior of a distant (virtualized or barebone) data repository server (see [DSOpal](https://github.com/datashield/DSOpal) for instance). The
datasets that are being analyzed are fully accessible in the local environment. The DataSHIELD configuration (set of 
allowed aggregation and assignment functions) is discovered at runtime by inspecting the DataSHIELD server-side R packages
installed locally. This configuration can also be amended or provided explicitly.

The DSLite "server" (see [DSLiteServer](https://github.com/datashield/DSLite/blob/master/R/DSLiteServer.R)) is a 
[R6](https://adv-r.hadley.nz/r6.html) class. An instance of this class will host the datasets to be analyzed and the DataSHIELD
configuration and will perform the DataSHIELD operations in the context of a session (a contained R environment).

`DSLite` can be used to:

* speed up development and testing cycle when developping new DataSHIELD functions (both at server and client side): no
need to deploy a data repository infrastructure.
* allow DataSHIELD analysis with combined datasets, some of them being accessible remotely in secure data repositories, 
others being privatly accessible (in a governmental institution for instance).

The following figure illustrates a setup where a single [DSLiteServer](https://github.com/datashield/DSLite/blob/master/R/DSLiteServer.R) 
holds several data frames and is used by two different DataSHIELD Connection ([DSConnection](https://github.com/datashield/DSI)) objects. 
All these objects live in the same R environment (usually the Global Environment). The "server" is responsible of managing DataSHIELD 
sessions that are implemented as distinct R environments inside of which R symbols are assigned and R functions are evaluated. 
Using the R environment paradigm ensures that the different DataSHIELD execution context (client and servers) are contained and exclusive from each other.

![DSLite architecture](https://raw.githubusercontent.com/datashield/DSLite/master/inst/images/dslite.png)

See usage [examples](https://github.com/datashield/DSLite/tree/master/inst/examples).

Article about DataSHIELD:
* [DataSHIELD: taking the analysis to the data, not the data to the analysis](https://doi.org/10.1093/ije/dyu188)
