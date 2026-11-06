TOKENS = c('NAME', 'STRING', 'DBLSTRING', 'INTEGER', 'NUMBER', 'PCTOP', 'NOTOP')
# these are "LEXEMES" (ref: https://stackoverflow.com/questions/14954721/what-is-the-difference-between-a-token-and-a-lexeme)
LITERALS = c('=', '+', '-', '*', '/', '(', ')', ',', '~', '^', ':', '!')

Lexer <- R6::R6Class(
  classname = "Lexer",
  public = list(
    tokens = TOKENS,
    literals = LITERALS,
    
    t_NAME = '[a-zA-Z_][a-zA-Z\\d_\\$\\.]*',
    
    t_STRING = '\'[a-zA-Z\\d_+-;:\\$]*\'',
    
    t_DBLSTRING = '"[a-zA-Z\\d_\\.+-;:\\$]*"',
    
    t_INTEGER = '\\d+L',
    
    t_NUMBER = '\\d+(\\.\\d+)?([eE][+-]?\\d+)?',
    
    t_PCTOP = '%[a-z*/]*%',
    
    t_NOTOP = '!',
    
    t_ignore = " \t\n\r",
    
    t_error = function(t) {
      #cat(sprintf("Illegal character '%s'", t$value[1]))
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
    # From the loosest to the tightest binding, see ?Syntax
    precedence = list(
      c('right', '='),
      c('left', '~'),
      c('right', 'NOTOP'),
      c('left', '+', '-'),
      c('left', '*', '/'),
      c('left', 'PCTOP'),
      c('left', ':'),
      c('right', 'UMINUS'),
      c('right', '^')
    ),
    
    p_expression_named = function(doc='expression : NAME "=" expression', p) {
      op <- ParameterNode$new(p$get(3))
      op$add_child(SymbolNode$new(p$get(2)))
      op$add_child(p$get(4))
      p$set(1, op)
    },
    
    p_expression_formula = function(doc='expression : expression "~" expression', p) {
      op <- FormulaNode$new(p$get(3))
      op$add_child(p$get(2))
      op$add_child(p$get(4))
      # formulas are not mapped to the configured methods
      op$accept(list(visit = function(node) {
        if (inherits(node, c("FunctionNode", "StringNode")))
          stop(sprintf("Syntax error in formula at '%s'", node$name))
      }))
      p$set(1, op)
    },
    
    p_expression_binop = function(doc="expression : expression '+' expression
                                                  | expression '-' expression
                                                  | expression '*' expression
                                                  | expression '/' expression
                                                  | expression '^' expression
                                                  | expression ':' expression
                                                  | expression PCTOP expression", p) {
      if (p$get(3) == ':') {
        op <- RangeNode$new(p$get(3))
        op$add_child(p$get(2))
        op$add_child(p$get(4))
        p$set(1, op)
      } else {
        op <- BinaryOpNode$new(p$get(3))
        op$add_child(p$get(2))
        op$add_child(p$get(4))
        p$set(1, op)
      }
    },
    
    p_expression_uminus = function(doc="expression : '-' expression %prec UMINUS
                                                  | '+' expression %prec UMINUS", p) {
      op <- UnaryOpNode$new(p$get(2))
      op$add_child(p$get(3))
      p$set(1, op)
    },
    
    p_expression_not = function(doc="expression : NOTOP expression", p) {
      op <- UnaryOpNode$new("!")
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
    
    p_function_empty = function(doc="expression : NAME '(' ')'", p) {
      fn <- FunctionNode$new(p$get(2))
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
    
    p_expression_string = function(doc='expression : STRING', p) {
      p$set(1, StringNode$new(p$get(2)))
    },
    
    p_expression_dblstring = function(doc='expression : DBLSTRING', p) {
      p$set(1, StringNode$new(p$get(2)))
    },
    
    p_expression_integer = function(doc='expression : INTEGER', p) {
      p$set(1, NumericNode$new(p$get(2)))
    },
    
    p_expression_number = function(doc='expression : NUMBER', p) {
      p$set(1, NumericNode$new(p$get(2)))
    },
    
    p_expression_name = function(doc='expression : NAME', p) {
      p$set(1, SymbolNode$new(p$get(2)))
    },
    
    p_error = function(p) {
      if (is.null(p))
        stop("Syntax error at EOF")
      else
        stop(sprintf("Syntax error at '%s'", p$value))
    }
  )
)
