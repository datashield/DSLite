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

  testServ$assignExpr(sid, "N", "sum(D$PM_BMI_CONTINUOUS, na.rm = TRUE)")
  expect_equal(testServ$symbols(sid), c("D", "N"))
  expect_equal(testServ$getSessionData(sid, "N"), 56604.36)

  expect_equal(testServ$aggregate(sid, "length(N)"), 1)
  expect_equal(testServ$aggregate(sid, quote(length(N))), 1)
  expect_equal(testServ$aggregate(sid, "colnames(D)"),
              c("LAB_TSC","LAB_TRIG","LAB_HDL","LAB_GLUC_ADJUSTED","PM_BMI_CONTINUOUS",
                "DIS_CVA","MEDI_LPD","DIS_DIAB","DIS_AMI","GENDER","PM_BMI_CATEGORICAL"))
  expect_equal(testServ$aggregate(sid, call("ls")), c("D", "N"))

  testServ$closeSession(sid)
  expect_false(testServ$hasSession(sid))
})

test_that("strict mode applies to nested function calls", {
  methods <- data.frame(name = c("length", "sum"), value = c("base::length", "base::sum"),
                        class = "function", stringsAsFactors = FALSE)
  serv <- DSLite::DSLiteServer$new(config = list(AggregateMethods = methods), strict = TRUE)
  sid <- serv$newSession()

  expect_equal(serv$aggregate(sid, "length(sum(1))"), 1)
  for (expr in c("nchar('a')", "length(nchar('a'))", "1 + nchar('a')", "-nchar('a')", "(nchar('a'))", "x = nchar('a')"))
    expect_error(serv$aggregate(sid, expr), "does not allow expression: nchar")

  serv$closeSession(sid)
})

test_that("options operations work", {
  testServ$options(list(foo="bar"))
  expect_equal(testServ$options(), list(foo="bar"))
  expect_equal(testServ$option("foo"), "bar")
  expect_equal(testServ$option("toto"), NULL)
  testServ$option("foo", "123")
  expect_equal(testServ$option("foo"), "123")
  testServ$option("foo", NULL)
  expect_equal(testServ$option("foo"), NULL)
  expect_equal(length(testServ$options()), 0)
})

test_that("methods operations work", {
  testServ$aggregateMethod("foo", "bar")
  expect_equal(testServ$aggregateMethod("foo"), "bar")
  expect_equal(testServ$aggregateMethod("toto"), NULL)
  testServ$aggregateMethod("foo", "base::bar")
  expect_equal(testServ$aggregateMethod("foo"), "base::bar")
  testServ$aggregateMethod("foo", NULL)
  expect_equal(testServ$aggregateMethod("foo"), NULL)

  testServ$assignMethod("foo", "bar")
  expect_equal(testServ$assignMethod("foo"), "bar")
  expect_equal(testServ$assignMethod("toto"), NULL)
  testServ$assignMethod("foo", "base::bar")
  expect_equal(testServ$assignMethod("foo"), "base::bar")
  testServ$assignMethod("foo", NULL)
  expect_equal(testServ$aggregateMethod("foo"), NULL)
})

test_that("aggregate rejects assignments", {
  methods <- data.frame(name = "length", value = "base::length", class = "function", stringsAsFactors = FALSE)
  serv <- DSLite::DSLiteServer$new(config = list(AggregateMethods = methods), strict = TRUE)
  sid <- serv$newSession()
  expect_error(serv$aggregate(sid, "length((x = 1))"), "Assignments are not allowed")
  expect_false(exists("x", envir = serv$getSession(sid), inherits = FALSE))
  serv$closeSession(sid)
})

test_that("expressions are validated without configured methods", {
  serv <- DSLite::DSLiteServer$new(config = list(), strict = TRUE)
  sid <- serv$newSession()
  expect_error(serv$aggregate(sid, "length((x = 1))"), "Assignments are not allowed")
  expect_error(serv$aggregate(sid, "1 + 1"), "must invoke a function")
  expect_equal(serv$aggregate(sid, "length(1:3)"), 3)
  serv$closeSession(sid)
})
