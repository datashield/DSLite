context("test-parser")

#
# Numbers
#

test_that("A number", {
  ast <- DSLite::testParse("3")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "3")
})

test_that("A negative number", {
  ast <- DSLite::testParse("-0.43151402098822")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "-0.43151402098822")
})

test_that("A number with floating point", {
  ast <- DSLite::testParse("3.1")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "3.1")
})

test_that("A number with floating point and exponent", {
  ast <- DSLite::testParse("3.1e4")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "3.1e4")
  # upper case exponent
  ast <- DSLite::testParse("3.1E4")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "3.1E4")
})

test_that("A number with floating point, exponent and negative signs", {
  ast <- DSLite::testParse("-3.1e-4")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "-3.1e-4")
})

test_that("A number with floating point, exponent and positive signs", {
  ast <- DSLite::testParse("+3.1e+4")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "+3.1e+4")
})

test_that("An integer", {
  ast <- DSLite::testParse("3L")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "3L")
})

#
# Strings
#

test_that("An single quote string", {
  ast <- DSLite::testParse("'A'")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "'A'")
  
  ast <- DSLite::testParse("'A_b.123$Z:A2'")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "'A_b.123$Z:A2'")
  
  ast <- DSLite::testParse("'3L'")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "'3L'")

  ast <- DSLite::testParse("'-3.1e+4'")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "'-3.1e+4'")
  
  ast <- DSLite::testParse("''")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "''")
})

test_that("An double quote string", {
  ast <- DSLite::testParse("\"A\"")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "\"A\"")
  
  ast <- DSLite::testParse("\"A_b.123$Z:A2\"")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "\"A_b.123$Z:A2\"")
  
  ast <- DSLite::testParse("\"3L\"")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "\"3L\"")
  
  ast <- DSLite::testParse("\"-3.1e+4\"")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "\"-3.1e+4\"")
  
  ast <- DSLite::testParse("\"\"")
  expect_true(inherits(ast, "StringNode"))
  expect_equal(ast$to_string(), "\"\"")
})

test_that("String with invalid chars", {
  expect_error(DSLite::testParse("'A%B'"))
  expect_error(DSLite::testParse("'A@B'"))
  expect_error(DSLite::testParse("'A&B'"))
  expect_error(DSLite::testParse("'A|B'"))
  expect_error(DSLite::testParse("'A B'"))
  expect_error(DSLite::testParse("'A(B)'"))
  expect_error(DSLite::testParse("'A[B]'"))
  expect_error(DSLite::testParse("'A*B'"))
  # FIXME why not an error?
  #expect_error(ast <- DSLite::testParse("'A/B'"))
})

#
# Symbol
#

test_that("A symbol", {
  ast <- DSLite::testParse("abc")
  expect_true(inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "abc")

  ast <- DSLite::testParse("abc-DEF.123X$var_12")
  expect_true(inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "abc-DEF.123X$var_12")
})

#
# Parameter
#

test_that("A named expression", {
  ast <- DSLite::testParse("abc = 'pwel'")
  expect_true(inherits(ast, "ParameterNode"))
  expect_equal(ast$to_string(), "abc = 'pwel'")

  ast <- DSLite::testParse("abc='pwel'")
  expect_true(inherits(ast, "ParameterNode"))
  expect_equal(ast$to_string(), "abc = 'pwel'")
})

#
# Operators
#

test_that("Arithmetic binary operators", {
  ast <- DSLite::testParse("1 + 2 * 3/4 - 5")
  expect_true(inherits(ast, "BinaryOpNode"))
  expect_equal(ast$to_string(), "1 + 2 * 3 / 4 - 5")
})

test_that("Pct operators", {
  ast <- DSLite::testParse("A %in% B")
  expect_true(inherits(ast, "BinaryOpNode"))
  expect_equal(ast$to_string(), "A %in% B")
})

test_that("A range operation", {
  ast <- DSLite::testParse("1:10")
  expect_true(inherits(ast, "RangeNode"))
  expect_equal(ast$to_string(), "1:10")
})

test_that("Unary not operator", {
  ast <- DSLite::testParse("!A")
  expect_true(inherits(ast, "UnaryOpNode"))
  expect_equal(ast$to_string(), "!A")
})

#
# Group
#

test_that("Some groups", {
  ast <- DSLite::testParse("(A + B) * (C - D)")
  expect_true(inherits(ast$children[[1]], "GroupNode"))
  expect_true(inherits(ast$children[[2]], "GroupNode"))
  expect_equal(ast$to_string(), "(A + B) * (C - D)")
})

#
# Formula
#

test_that("A formula", {
  ast <- DSLite::testParse("A ~ B")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B")
  
  ast <- DSLite::testParse("A~B")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B")
  
  ast <- DSLite::testParse("A ~ B + C")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B + C")
})

test_that("A formula with operators", {
  ast <- DSLite::testParse("A ~ B + C")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B + C")
  
  ast <- DSLite::testParse("A ~ B + (C * D)")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B + (C * D)")
  
  ast <- DSLite::testParse("A ~ B^4")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B^4")
  
  ast <- DSLite::testParse("A ~ B : C")
  expect_true(inherits(ast, "RangeNode")) # FIXME should be FormulaNode
  expect_equal(ast$to_string(), "A ~ B:C")
  
  ast <- DSLite::testParse("A ~ B %in% C")
  expect_true(inherits(ast, "BinaryOpNode")) # FIXME should be FormulaNode
  expect_equal(ast$to_string(), "A ~ B %in% C")
  
  ast <- DSLite::testParse("A ~ B + (C * D)^4 : E %in% F")
  expect_true(inherits(ast, "BinaryOpNode")) # FIXME should be FormulaNode
  expect_equal(ast$to_string(), "A ~ B + (C * D)^4:E %in% F")
})

#
# Function
#

test_that("An empty function", {
  ast <- DSLite::testParse("some_func()")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func()")
  
  ast <- DSLite::testParse("some_func ( )")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func()")
  
  ast <- DSLite::testParse("some_func123.call$X()")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func123.call$X()")
})

test_that("A function with parameters", {
  ast <- DSLite::testParse("some_func(A)")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(A)")
  
  ast <- DSLite::testParse("some_func(123)")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(123)")
  
  ast <- DSLite::testParse("some_func('abc')")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func('abc')")
  
  ast <- DSLite::testParse("some_func(\"abc\")")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(\"abc\")")
  
  ast <- DSLite::testParse("some_func('D$X')")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func('D$X')")
  
  ast <- DSLite::testParse("some_func('1.2,1.3,-8.5')")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func('1.2,1.3,-8.5')")
  
  ast <- DSLite::testParse("some_func(x = 123)")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(x = 123)")
  
  ast <- DSLite::testParse("some_func(x = A ~ B)")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(x = A ~ B)")
  
  ast <- DSLite::testParse("some_func(another_func(A))")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(another_func(A))")
  
  ast <- DSLite::testParse("some_func(B, C(), D, E(F(G/H)), A + B * C())")
  expect_true(inherits(ast, "FunctionNode"))
  expect_equal(ast$to_string(), "some_func(B, C(), D, E(F(G / H)), A + B * C())")
})
