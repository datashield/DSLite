context("test-parser")

test_that("A number", {
  ast <- DSLite::dsParse("3")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "3")
})

test_that("A negative number", {
  ast <- DSLite::dsParse("-0.43151402098822")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "-0.43151402098822")
})

test_that("A number with floating point", {
  ast <- DSLite::dsParse("3.1")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "3.1")
})

test_that("A number with floating point and exponent", {
  ast <- DSLite::dsParse("3.1e4")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "3.1e4")
  # upper case exponent
  ast <- DSLite::dsParse("3.1E4")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "3.1E4")
})

test_that("A number with floating point, exponent and negative signs", {
  ast <- DSLite::dsParse("-3.1e-4")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "-3.1e-4")
})

test_that("A number with floating point, exponent and positive signs", {
  ast <- DSLite::dsParse("+3.1e+4")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "+3.1e+4")
})

test_that("An integer", {
  ast <- DSLite::dsParse("3L")
  expect_true(R6::is.R6(ast) && inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "3L")
})
