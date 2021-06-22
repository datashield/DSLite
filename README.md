# DataSHIELD Lite

[![Build Status](https://travis-ci.com/datashield/DSLite.svg?branch=master)](https://travis-ci.com/datashield/DSLite)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/DSLite)](https://cran.r-project.org/package=DSLite)

Serverless [DataSHIELD Interface (DSI)](https://datashield.github.io/DSI/) implementation which purpose is to mimic
the behavior of a distant (virtualized or barebone) data repository server (see [DSOpal](https://datashield.github.io/DSOpal/) for instance). The
datasets that are being analyzed are fully accessible in the local environment. The DataSHIELD configuration (set of 
allowed aggregation and assignment functions) is discovered at runtime by inspecting the DataSHIELD server-side R packages
installed locally. This configuration can also be amended or provided explicitly.

The DSLite "server" (see [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.html)) is a 
[R6](https://adv-r.hadley.nz/r6.html) class. An instance of this class will host the datasets to be analyzed and the DataSHIELD
configuration and will perform the DataSHIELD operations in the context of a session (a contained R environment).

`DSLite` can be used to:

* speed up development and testing cycle when developping new DataSHIELD functions (both at server and client side): no
need to deploy a data repository infrastructure.
* allow DataSHIELD analysis with combined datasets, some of them being accessible remotely in secure data repositories, 
others being privatly accessible (in a governmental institution for instance).

The following figure illustrates a setup where a single [DSLiteServer](https://datashield.github.io/DSLite/reference/DSLiteServer.html) 
holds several data frames and is used by two different DataSHIELD Connection ([DSConnection](https://datashield.github.io/DSI/reference/DSConnection-class.html)) objects. 
All these objects live in the same R environment (usually the Global Environment). The "server" is responsible for managing DataSHIELD 
sessions that are implemented as distinct R environments inside of which R symbols are assigned and R functions are evaluated. 
Using the [R environment](https://adv-r.hadley.nz/environments.html) paradigm ensures that the different DataSHIELD execution context 
(client and servers) are contained and exclusive from each other.

![DSLite architecture](https://raw.githubusercontent.com/datashield/DSLite/master/inst/images/dslite.png)

The minimum steps to follow for this kind of setup:

* make sure that both DataSHIELD client-side and server-side R packages are installed in your local R session, 
* load harmonized datasets in data frames (with the method of your choice),
* instanciate a new `DSLiteServer` and provide a named list of these data frames,
* prepare DataSHIELD logindata object where the `table` to assign is the name of one the data frames and the `url` is the symbol that refers to the `DSLiteServer` object,
* perform DataSHIELD login and do analysis.

See usage [examples](https://github.com/datashield/DSLite/tree/master/inst/examples).

Article about DataSHIELD:
* [DataSHIELD: taking the analysis to the data, not the data to the analysis](https://doi.org/10.1093/ije/dyu188)
