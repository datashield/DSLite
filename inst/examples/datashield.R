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

# List all available tables
datashield.tables(conns)

# List all available resources
datashield.resources(conns)

# Check assigned variables
datashield.symbols(conns)

# Table assignment can also happen later
datashield.assign(conns, "T", "CNSIM1", variables=c("GENDER"))
ds.class("T")
ds.colnames("T")
ds.class("T$GENDER")

# Execute some aggregate calls (if these methods are available in the conns)
ds.class("D")
ds.colnames("D")
ds.length("D$GENDER")

# clean symbols
datashield.rm(conns,'D')
datashield.symbols(conns)

# Assign and aggregate arbitrary values
datashield.assign(conns, "x", quote(c("1", "2", "3")))
ds.length("x")
ds.class("x")
datashield.assign(conns, "xn", quote(as.numeric(x)))
ds.class("xn")

datashield.assign(conns, "D", list(sim1="CNSIM1", sim2="CNSIM2", sim3="CNSIM3"))
ds.colnames("D")

# Example 1: run a GLM without interaction (e.g. diabetes prediction using BMI and HDL levels and GENDER)
mod <- ds.glm(formula='D$DIS_DIAB~D$GENDER+D$PM_BMI_CONTINUOUS+D$LAB_HDL', family='binomial')

# Example 2: run the above GLM model without an intercept
# (produces separate baseline estimates for Male and Female)
mod <- ds.glm(formula='D$DIS_DIAB~0+D$GENDER+D$PM_BMI_CONTINUOUS+D$LAB_HDL', family='binomial')

# Example 3: run the above GLM with interaction between GENDER and PM_BMI_CONTINUOUS
mod <- ds.glm(formula='D$DIS_DIAB~D$GENDER*D$PM_BMI_CONTINUOUS+D$LAB_HDL', family='binomial')

# Example 4: Fit a standard Gaussian linear model with an interaction
mod <- ds.glm(formula='D$PM_BMI_CONTINUOUS~D$DIS_DIAB*D$GENDER+D$LAB_HDL', family='gaussian')

# Example 5: now run a GLM where the error follows a poisson distribution
# P.S: A poisson model requires a numeric vector as outcome so in this example we first convert
# the categorical BMI, which is of type 'factor', into a numeric vector
ds.asNumeric('D$PM_BMI_CATEGORICAL','BMI.123')
mod <- ds.glm(formula='BMI.123~D$PM_BMI_CONTINUOUS+D$LAB_HDL+D$GENDER', family='poisson')

# Datashield config and status
datashield.methods(conns, type="aggregate")
datashield.methods(conns$sim1, type="aggregate")
datashield.method_status(conns, type="assign")
datashield.pkg_status(conns)
datashield.table_status(conns, list(sim1="CNSIM1", sim2="CNSIM2", sim3="CNSIM3"))
datashield.profiles(conns)

# Logout and save workspace
datashield.logout(conns, save = "test")

# Workspaces
conns <- datashield.login(logindata.dslite.cnsim, assign=FALSE, restore = "test")
datashield.symbols(conns)
datashield.workspaces(conns)
datashield.workspace_save(conns, "toto")
datashield.workspaces(conns)
datashield.workspace_rm(conns, "toto")
datashield.workspaces(conns)
datashield.logout(conns)
