#!/usr/bin/env Rscript

#
# Lite Datashield client
#

library(DSLite)
library(dsBaseClient)

# prepare data in a light DS server
data("CNSIM1")
data("CNSIM2")
data("CNSIM3")
dslite.server <- newDSLiteServer(tables=list(CNSIM1=CNSIM1, CNSIM2=CNSIM2, CNSIM3=CNSIM3))
dslite.server$config()
dslite.server$profile()

# datashield logins and assignments
data("logindata.dslite.cnsim")
conns <- datashield.login(logindata.dslite.cnsim, assign=T, variables=c("GENDER","PM_BMI_CONTINUOUS"), id.name="ID")

# list all available tables
datashield.tables(conns)

# list all available resources
datashield.resources(conns)

# check assigned variables
datashield.symbols(conns)

# table assignment can also happen later
datashield.assign(conns, "T", "CNSIM1", variables=c("GENDER"))
ds.class("T")
ds.colnames("T")
ds.class("T$GENDER")

# execute some aggregate calls (if these methods are available in the conns)
ds.class("D")
ds.colnames("D")
ds.length("D$GENDER")

# clean symbols
datashield.rm(conns,'D')
datashield.symbols(conns)

# assign and aggregate arbitrary values
datashield.assign(conns, "x", quote(c("1", "2", "3")))
ds.length("x")
ds.class("x")
datashield.assign(conns, "xn", quote(as.numeric(x)))
ds.class("xn")

datashield.methods(conns, type="aggregate")
datashield.methods(conns$sim1, type="aggregate")
datashield.method_status(conns, type="assign")
datashield.pkg_status(conns)
datashield.table_status(conns, list(sim1="CNSIM1", sim2="CNSIM2", sim3="CNSIM3"))

datashield.profiles(conns)

datashield.logout(conns, save = "test")

conns <- datashield.login(logindata.dslite.cnsim, assign=FALSE, restore = "test")
datashield.symbols(conns)
dsListWorkspaces(conns[[1]])
datashield.workspaces(conns)
datashield.workspace_save(conns, "toto")
datashield.workspaces(conns)
datashield.workspace_rm(conns, "toto")
datashield.workspaces(conns)
datashield.logout(conns)
