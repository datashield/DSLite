TOKENS = c('NAME', 'INTEGER', 'NUMBER')
# these are "LEXEMES" (ref: https://stackoverflow.com/questions/14954721/what-is-the-difference-between-a-token-and-a-lexeme)
LITERALS = c('=', '+', '-', '*', '/', '(', ')', ',')

Lexer <- R6::R6Class(
  classname = "Lexer",
  public = list(
    tokens = TOKENS,
    literals = LITERALS,
    
    t_NAME = '[a-zA-Z_][a-zA-Z0-9_]*',
    
    t_INTEGER = '\\d+L',
    
    t_NUMBER = '[+-]?\\d+(\\.\\d+)?([eE][+-]?\\d+)?',
    
    t_ignore = " \t\n\r",
    
    t_error = function(t) {
      cat(sprintf("Illegal character '%s'", t$value[1]))
      t$lexer$skip(1)
      return(t)
    }
  )
)

Parser <- R6::R6Class(
  classname = "Parser",
  public = list(
    tokens = TOKENS,
    literals = LITERALS,
    # Parsing rules
    precedence = list(
      c('left', '+', '-'),
      c('left', '*', '/'),
      c('right', 'UMINUS')
    ),
    # dictionary of names (can be inefficient but it's cool here)
    names = new.env(hash=TRUE),
    
    p_statement_assign = function(doc='statement : NAME "=" expression', p) {
      self$names[[as.character(p$get(2))]] <- p$get(4)
    },
    
    p_statement_expr = function(doc='statement : expression', p) {
      p$set(1, p$get(2))
    },
    
    p_expression_binop = function(doc="expression : expression '+' expression
                                                  | expression '-' expression
                                                  | expression '*' expression
                                                  | expression '/' expression", p) {
      op <- BinaryOpNode$new(p$get(3))
      op$add_child(p$get(2))
      op$add_child(p$get(4))
      p$set(1, op)
    },
    
    p_expression_uminus = function(doc="expression : '-' expression %prec UMINUS", p) {
      op <- UnaryOpNode$new("-")
      op$add_child(p$get(3))
      p$set(1, op)
    },
    
    p_expression_group = function(doc="expression : '(' expression ')'", p) {
      gn <- GroupNode$new()
      gn$add_child(p$get(3))
      p$set(1, gn)
    },
    
    p_function = function(doc="expression : NAME '(' expression_list ')'", p) {
      fn <- FunctionNode$new(p$get(2))
      for (expr in p$get(4))
        fn$add_child(expr)
      p$set(1, fn)
    },
    
    p_expression_list = function(doc="expression_list : expression_list ',' expression
                                                      | expression", p) {
      if(p$length() > 3) {
        p$set(1, append(p$get(2), p$get(4)))
      } else {
        p$set(1, list(p$get(2)))
      }
    },
    
    p_expression_integer = function(doc='expression : INTEGER', p) {
      p$set(1, SymbolNode$new(p$get(2)))
    },
    
    p_expression_number = function(doc='expression : NUMBER', p) {
      p$set(1, SymbolNode$new(p$get(2)))
    },
    
    p_expression_name = function(doc='expression : NAME', p) {
      p$set(1, self$names[[as.character(p$get(2))]])
    },
    
    p_error = function(p) {
      if (is.null(p))
        cat("Syntax error at EOF")
      else
        cat(sprintf("Syntax error at '%s'", p$value))
    }
  )
)
