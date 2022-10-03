#' Parse an expression according DataSHIELD syntax rules and returns an Abstract Syntaxic Tree (AST) node.
#'
#' @param expr Expression
#' @param debug Parser debug logger activated
#' @return An Abstract Syntaxic Tree node
#'
#' @export
#' @import rly
testParse <- function(expr, debug = FALSE) {
  lexer <- rly::lex(Lexer)
  parser <- rly::yacc(Parser)
  logger <- rly::NullLogger$new()
  if (debug)
    logger <- rly::RlyLogger$new()
  parser$parse(expr, lexer, debug = logger)
}
