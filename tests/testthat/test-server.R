context("test-server")

data("CNSIM1")
data("CNSIM2")
data("CNSIM3")
testServ <- DSLite::DSLiteServer$new(tables=list(CNSIM1=CNSIM1, CNSIM2=CNSIM2, CNSIM3=CNSIM3), strict = FALSE)

test_that("tables operations work", {
  expect_equal(testServ$tableNames(), c("CNSIM1", "CNSIM2", "CNSIM3"))
  expect_true(testServ$hasTable("CNSIM1"))
  expect_false(testServ$hasTable("CNSIM1xxx"))
})

test_that("session operations work", {
  sid <- testServ$newSession()
  expect_true(is.character(sid))
  expect_true(testServ$hasSession(sid))
  expect_equal(length(testServ$symbols(sid)), 0)

  testServ$assignTable(sid, "D", "CNSIM1")
  expect_equal(testServ$symbols(sid), c("D"))

  testServ$assignExpr(sid, "N", "sum(D$PM_BMI_CONTINUOUS)")
  expect_equal(testServ$symbols(sid), c("D", "N"))

  expect_equal(testServ$aggregate(sid, "length(N)"), 1)
  expect_equal(testServ$aggregate(sid, quote(length(N))), 1)
  expect_equal(testServ$aggregate(sid, "colnames(D)"),
              c("LAB_TSC","LAB_TRIG","LAB_HDL","LAB_GLUC_ADJUSTED","PM_BMI_CONTINUOUS",
                "DIS_CVA","MEDI_LPD","DIS_DIAB","DIS_AMI","GENDER","PM_BMI_CATEGORICAL"))
  expect_equal(testServ$aggregate(sid, call("ls")), c("D", "N"))

  testServ$closeSession(sid)
  expect_false(testServ$hasSession(sid))
})
