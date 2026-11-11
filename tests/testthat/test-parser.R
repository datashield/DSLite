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
  expect_true(inherits(ast, "UnaryOpNode"))
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
  expect_true(inherits(ast, "UnaryOpNode"))
  expect_equal(ast$to_string(), "-3.1e-4")
})

test_that("A number with floating point, exponent and positive signs", {
  ast <- DSLite::testParse("3.1e+4")
  expect_true(inherits(ast, "NumericNode"))
  expect_equal(ast$to_string(), "3.1e+4")
  # no unary plus, as in datashield4j
  expect_error(DSLite::testParse("+3.1e+4"))
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
  expect_error(DSLite::testParse("'A\\B'"))
  expect_error(DSLite::testParse("'A<-B'"))
  expect_error(DSLite::testParse("'A\""))
  expect_error(DSLite::testParse("\"A'"))
  # FIXME why not an error? problem with R regexpr?
  #expect_error(ast <- DSLite::testParse("'A/B'", debug = T))
})

#
# Symbol
#

test_that("A symbol", {
  ast <- DSLite::testParse("abc")
  expect_true(inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "abc")

  ast <- DSLite::testParse("abc.DEF.123X$var_12")
  expect_true(inherits(ast, "SymbolNode"))
  expect_equal(ast$to_string(), "abc.DEF.123X$var_12")
})

test_that("Symbol with invalid chars", {
  expect_error(DSLite::testParse("A[2, 1]"))
  expect_error(DSLite::testParse("A[2, 1:2]"))
  expect_error(DSLite::testParse("A[, 1]"))
  expect_error(DSLite::testParse("A[1,]"))
  expect_error(DSLite::testParse("A[, 1:2]"))
  expect_error(DSLite::testParse("A[]"))
  expect_error(DSLite::testParse("A[,]"))
  expect_error(DSLite::testParse("A[[]]"))
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

test_that("Minus sign is an operator", {
  expect_equal(DSLite::testParse("1-1")$to_string(), "1 - 1")
  expect_equal(DSLite::testParse("x -1")$to_string(), "x - 1")
  expect_equal(DSLite::testParse("x+1")$to_string(), "x + 1")
  expect_equal(DSLite::testParse("-1L")$to_string(), "-1L")

  ast <- DSLite::testParse("a-f(1)")
  expect_true(inherits(ast, "BinaryOpNode"))
  expect_true(inherits(ast$children[[2]], "FunctionNode"))
  expect_equal(ast$children[[2]]$name, "f")

  ast <- DSLite::testParse("a-(b)")
  expect_true(inherits(ast, "BinaryOpNode"))
  expect_equal(ast$to_string(), "a - (b)")
})

test_that("Power and pct operators", {
  expect_equal(DSLite::testParse("a^2")$to_string(), "a^2")
  expect_equal(DSLite::testParse("A %*% B")$to_string(), "A %*% B")
  expect_equal(DSLite::testParse("A %% B")$to_string(), "A %% B")
  expect_equal(DSLite::testParse("A %/% B")$to_string(), "A %/% B")
})

test_that("Operators follow R precedence", {
  # the shape of the tree must be the one R gives: operator at the root, then its operands
  root <- function(expr) {
    ast <- DSLite::testParse(expr)
    c(ast$name, ast$children[[1]]$to_string())
  }
  expect_equal(root("a * b + c"), c("+", "a * b"))
  expect_equal(root("a - b - c"), c("-", "a - b"))
  expect_equal(root("a^b^c"), c("^", "a"))
  expect_equal(root("-2^2"), c("-", "2^2"))
  expect_equal(root("-1:3"), c(":", "-1"))
  expect_equal(root("1:3^2"), c(":", "1"))
  expect_equal(root("2 * 1:3"), c("*", "2"))
})

test_that("Round trip is the same expression for R", {
  for (expr in c("a*b-c", "-2^2", "1:3^2", "2^1:3", "-1:3", "a^b^c", "1-1", "x -1", "a-f(1)", "f(1 -2)",
                 "a %*% b", "y-1 ~ x", "a + b ~ c", "y ~ -x", "y ~ x -1", "y ~ a/b + c", "-y ~ x"))
    expect_identical(parse(text = DSLite::testParse(expr)$to_string())[[1]], parse(text = expr)[[1]], info = expr)
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
  
  ast <- DSLite::testParse("A ~ B.C_123$D")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B.C_123$D")

  ast <- DSLite::testParse("A ~ 123")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ 123")
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
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B:C")
  
  ast <- DSLite::testParse("A ~ (B : C)")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ (B:C)")
  
  ast <- DSLite::testParse("A ~ B %in% C")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B %in% C")
  
  ast <- DSLite::testParse("A ~ (B %in% C)")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ (B %in% C)")
  
  ast <- DSLite::testParse("A ~ B + (C * D)^4 : E %in% F")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B + (C * D)^4:E %in% F")

  ast <- DSLite::testParse("A ~ B / C")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ B / C")

  ast <- DSLite::testParse("A ~ -1 + B")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A ~ -1 + B")
})

test_that("A formula with an expression as response", {
  ast <- DSLite::testParse("A-1~B")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A - 1 ~ B")

  ast <- DSLite::testParse("A + B ~ C")
  expect_true(inherits(ast, "FormulaNode"))
  expect_equal(ast$to_string(), "A + B ~ C")
})

test_that("Formula with invalid syntax", {
  expect_error(DSLite::testParse("A ~ 'abc'"))
  expect_error(DSLite::testParse("D$height ~ D$diameter + poly(D$length, 3, raw=TRUE)"))
  expect_error(DSLite::testParse("log(A) ~ B"))
  expect_error(DSLite::testParse("A ~ (log(B))"))
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

test_that("Validation is aligned with datashield4j", {
  valid <- function(expr, aggregate = FALSE) DSLite:::validateNode(DSLite::testParse(expr), aggregate)
  for (expr in c("1:10", "c(-1:3)", "f(1:(2*3))", "f(2^1:3)", "f(y ~ a:b)", "f(x = 1)", "f(x.y_1 = 1)", "x = f(1)"))
    expect_silent(valid(expr))
  for (expr in c("f(1:n)", "f(D$A:3)", "f(1:g(3))", "f('a':3)"))
    expect_error(valid(expr), "Range operands must be numbers")
  expect_error(valid("f(D$A = 1)"), "Invalid argument name")
  expect_error(valid("f(_a = 1)"), "Invalid argument name")
  expect_error(valid("f((x = 1))", aggregate = TRUE), "Assignments are not allowed")
  expect_silent(valid("f(x = 1)", aggregate = TRUE))
  expect_silent(valid("f('x' = 1, \"y\" = 2)"))
  expect_equal(DSLite::testParse("f('x' = 1)")$to_string(), "f('x' = 1)")
  expect_error(DSLite::testParse("+1"))
  for (expr in c("1 + f(1)", "-f(1)", "x", "'a'", "x = f(1)"))
    expect_error(valid(expr, aggregate = TRUE), "must invoke a function|Assignments")
  expect_silent(valid("((f(1)))", aggregate = TRUE))
  expect_error(valid("1 + f(1)", aggregate = TRUE), "must invoke a function")
})
