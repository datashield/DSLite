#' Parse an expression according DataSHIELD syntax rules.
#'
#' @param expr Expression
#' @param debug Parser debug logger
#' @return An Abstract Syntaxic Tree node
#'
#' @export
#' @import rly
dsParse <- function(expr, debug = rly::NullLogger$new()) {
  lexer  <- rly::lex(Lexer)
  parser <- rly::yacc(Parser)
  parser$parse(expr, lexer, debug = debug)
}

