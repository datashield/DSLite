#' Parse an expression according to DataSHIELD syntax rules and returns an Abstract Syntaxic Tree (AST) node.
#'
#' @param expr Expression
#' @param debug Parser debug logger activated
#' @return An Abstract Syntaxic Tree node
#' @examples
#' \dontrun{
#' # a function call with a valid formula
#' ast <- testParse("someregression(D$height ~ D$diameter + D$length)")
#' # a function call with an invalid formula including a function call
#' testParse("someregression(D$height ~ D$diameter + poly(D$length,3,raw=TRUE))")
#' }
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
