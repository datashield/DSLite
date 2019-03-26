context("test-dsi")

data("CNSIM1")
data("CNSIM2")
data("CNSIM3")
testServ <- DSLite::DSLiteServer$new(tables=list(CNSIM1=CNSIM1, CNSIM2=CNSIM2, CNSIM3=CNSIM3))
testServ$aggregateMethod("summary", "base::summary")
testServ$assignMethod("length", "base::length")
options(datashield.env=environment())
conn <- dsConnect(DSLite::DSLite(), name="server1", url="testServ")

test_that("capabilities getters works", {
  expect_equal(dsListTables(conn), c("CNSIM1", "CNSIM2", "CNSIM3"))
  expect_true(dsHasTable(conn, "CNSIM1"))
  expect_true(!dsHasTable(conn, "CNSIM1xx"))
  async <- dsIsAsync(conn)
  expect_true(is.list(async))
  expect_true(!async$aggregate)
  expect_true(!async$assignTable)
  expect_true(!async$assignExpr)
})

test_that("assign table works", {
  res <- dsAssignTable(conn, "D", "CNSIM1")
  info <- dsGetInfo(res)
  expect_equal(info$status, "COMPLETED")
  expect_null(dsFetch(res))
  expect_equal(dsListSymbols(conn), "D")
})

test_that("assign expression works", {
  res <- dsAssignExpr(conn, "N", "length(D$PM_BMI_CONTINUOUS)")
  info <- dsGetInfo(res)
  expect_equal(info$status, "COMPLETED")
  expect_null(dsFetch(res))
  expect_equal(dsListSymbols(conn), c("D", "N"))
})

test_that("aggregate expression works", {
  res <- dsAggregate(conn, "summary(D$PM_BMI_CONTINUOUS)")
  info <- dsGetInfo(res)
  expect_equal(info$status, "COMPLETED")
  rval <- dsFetch(res)
  expect_equal(rval[["Mean"]], 27.398, tolerance=1e-3)
})

test_that("symbols management works", {
  expect_equal(dsListSymbols(conn), c("D", "N"))
  dsRmSymbol(conn, "N")
  expect_equal(dsListSymbols(conn), "D")
})

dsDisconnect(conn)
