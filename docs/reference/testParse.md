# Parse an expression according to DataSHIELD syntax rules and returns an Abstract Syntaxic Tree (AST) node.

Parse an expression according to DataSHIELD syntax rules and returns an
Abstract Syntaxic Tree (AST) node.

## Usage

``` r
testParse(expr, debug = FALSE)
```

## Arguments

- expr:

  Expression

- debug:

  Parser debug logger activated

## Value

An Abstract Syntaxic Tree node

## Examples

``` r
if (FALSE) { # \dontrun{
# a function call with a valid formula
ast <- testParse("someregression(D$height ~ D$diameter + D$length)")
# a function call with an invalid formula including a function call
testParse("someregression(D$height ~ D$diameter + poly(D$length,3,raw=TRUE))")
} # }
```
