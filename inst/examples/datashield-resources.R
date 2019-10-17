library(resourcer)
library(DSLite)
library(DSOpal)

cnsim1 <- resourcer::newResource("CNSIM1", "https://github.com/datashield/DSLite/raw/master/data/CNSIM1.rda", format = "data.frame")
cnsim2 <- resourcer::newResource("CNSIM2", "https://github.com/datashield/DSLite/raw/master/data/CNSIM2.rda", format = "data.frame")
cnsim3 <- resourcer::newResource("CNSIM3", "https://github.com/datashield/DSLite/raw/master/data/CNSIM3.rda", format = "data.frame")
dslite.server <- newDSLiteServer(resources = list(cnsim1 = cnsim1, cnsim2 = cnsim2, cnsim3 = cnsim3))
dslite.server$resourceNames()
dslite.server$config()
dslite.server$assignMethod("as.df", "base::as.data.frame")

builder <- DSI::newDSLoginBuilder()
builder$append(server = "server1", url = "dslite.server", resource = "cnsim1", driver = "DSLiteDriver")
builder$append(server = "server2", url = "dslite.server", resource = "cnsim2", driver = "DSLiteDriver")
builder$append(server = "server3", url = "dslite.server", resource = "cnsim3", driver = "DSLiteDriver")
builder$append(server = "server4", url = "http://localhost:8080", user = "administrator", password = "password", resource = "datashield.cnsim3", driver = "OpalDriver")
builder$build()
logindata.dslite.cnsim <- builder$build()
logindata.dslite.cnsim

conns <- datashield.login(logindata.dslite.cnsim, assign=T)
datashield.symbols(conns)
datashield.aggregate(conns,'class(D)')

datashield.assign.expr(conns, "df", quote(as.df(D)))
datashield.symbols(conns)
datashield.aggregate(conns,'class(df)')

library(dsBaseClient)
ds.colnames("df")
ds.summary("df")
ds.summary("df$LAB_HDL")

datashield.logout(conns)
