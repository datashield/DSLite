#' @title Simple AST node
#'
#' @description Abstract Syntaxic Tree (AST) node that will be created by the DSLite R parser.
#'
#' @field name Token value
#' @field parent Parent Node
#' @field children Children Nodes
#' 
#' @family parser items
#' @docType class
#' @import R6
#' @export
Node <- R6::R6Class(
  "Node",
  public = list(
    name = NULL,
    parent = NULL,
    children = NULL,
    
    #' @description Simple node constructor
    #' @param name Token value
    #' @param parent Parent Node
    #' @return A Node object
    initialize = function(name = NA, parent = NA) {
      self$name <- name
      self$parent <- parent
    },
    
    #' @description Set parent Node
    #' @param val Parent Node
    set_parent = function(val) {
      if (!R6::is.R6(val) || !inherits(val, "Node"))
        stop("Not a parent Node object")
      self$parent <- val
    },
    
    #' @description Add a child Node
    #' @param val Child Node
    add_child = function(val) {
      if (!R6::is.R6(val) || !inherits(val, "Node"))
        stop("Not a child Node object")
      if (is.null(self$children)) {
        self$children <- c(val)
      } else {
        self$children <- append(self$children, val)
      }
      if (!is.null(val))
        val$set_parent(self)
    },
    
    #' @description The string representation of the Node 
    to_string = function() {
      str <- ""
      if (!is.na(self$name))
        str <- self$name
      paste0(str, self$to_string_children())
    },
    
    #' @description Get the string representation of the Node's children 
    to_string_children = function() {
      str <- ""
      if (!is.null(self$children)) {
        for (child in self$children) {
          if (!is.null(child)) {
            str <- paste0(str, child$to_string())
          }
        }
      }
      str
    },
    
    #' @description Accept visitor
    #' @param visitor Node visitor object
    accept = function(visitor) {
      visitor$visit(self)
      if (!is.null(self$children)) {
        for (child in self$children) {
          if (!is.null(child)) {
            child$accept(visitor)
          }
        }
      }
    }
  )
)

#' @title Function AST node
#'
#' @description AST node that represents a function with its arguments.
#'
#' @family parser items
#' @docType class
#' @import R6
#' @export
FunctionNode <- R6::R6Class(
  "FunctionNode",
  inherit = Node,
  public = list(
    
    #' @description Get the string representation of the FunctionNode
    to_string = function() {
      str <- paste0(self$name, "(")
      if (!is.null(self$children)) {
        for (i in 1:length(self$children)) {
          child <- self$children[[i]]
          if (!is.null(child)) {
            if (i>1)
              str <- paste0(str, ", ")
            str <- paste0(str, child$to_string())
          }
        }
      }
      paste0(str, ")")
    }
  )
)

#' @title Symbol AST node
#'
#' @description AST node that represents a R symbol (variable name, function name etc.).
#'
#' @family parser items
#' @docType class
#' @import R6
#' @export
SymbolNode <- R6::R6Class(
  "SymbolNode",
  inherit = Node,
  public = list(
    
    #' @description No children
    #' @param val Child Node
    add_child = function(val) {
      stop("Symbol node has no children")
    },
    
    #' @description Get the string representation of the SymbolNode
    to_string = function() {
      as.character(self$name)
    }
  )
)

#' @title Numeric AST node
#'
#' @description AST node that reprsents a numeric (integer or float) value.
#'
#' @family parser items
#' @docType class
#' @import R6
#' @export
NumericNode <- R6::R6Class(
  "NumericNode",
  inherit = Node,
  public = list(
    
    #' @description No children
    #' @param val Child Node
    add_child = function(val) {
      stop("Numeric node has no children")
    },
    
    #' @description Get the string representation of the NumericNode
    to_string = function() {
      as.character(self$name)
    }
  )
)

#' @title String AST node
#'
#' @description AST node that represent a string value, either single or double quoted.
#'
#' @family parser items
#' @docType class
#' @import R6
#' @export
StringNode <- R6::R6Class(
  "StringNode",
  inherit = Node,
  public = list(
    
    #' @description No children
    #' @param val Child Node
    add_child = function(val) {
      stop("String node has no children")
    },
    
    #' @description Get the string representation of the StringNode
    to_string = function() {
      self$name
    }
  )
)

#' @title Unary operator AST node
#'
#' @description AST node that represents a unary operator (such as '-'), therefore having a single child node.
#'
#' @family parser items
#' @docType class
#' @import R6
#' @export
UnaryOpNode <- R6::R6Class(
  "UnaryOpNode",
  inherit = Node,
  public = list(
    
    #' @description One children
    #' @param val Child Node
    add_child = function(val) {
      if (length(self$children)>0)
        stop("Unary operator node has only one operand")
      super$add_child(val)
    },
    
    #' @description Get the string representation of the UnaryOpNode
    to_string = function() {
      paste0(self$name, self$children[[1]]$to_string())
    }
  )
)

#' @title Parameter AST node
#'
#' @description AST node that represents a function's named parameter (such as NAME = <expression>).
#'
#' @family parser items
#' @docType class
#' @import R6
ParameterNode <- R6::R6Class(
  "ParameterNode",
  inherit = Node,
  public = list(
    
    #' @description Two children
    #' @param val Child Node
    add_child = function(val) {
      if (length(self$children)>1)
        stop("ParameterNode node has only two children")
      super$add_child(val)
    },
    
    #' @description Get the string representation of the BinaryOpNode
    to_string = function() {
      paste0(self$children[[1]]$to_string(), " = ", self$children[[2]]$to_string())
    }
  )
)

#' @title Formula AST node
#'
#' @description AST node that reprsents a formula (such as NAME ~ <terms>).
#'
#' @family parser items
#' @docType class
#' @import R6
FormulaNode <- R6::R6Class(
  "FormulaNode",
  inherit = Node,
  public = list(
    
    #' @description Two children
    #' @param val Child Node
    add_child = function(val) {
      if (length(self$children)>1)
        stop("FormulaNode node has only two children")
      super$add_child(val)
    },
    
    #' @description Get the string representation of the BinaryOpNode
    to_string = function() {
      paste0(self$children[[1]]$to_string()," ~ ", self$children[[2]]$to_string())
    }
  )
)

#' @title Binary operation AST node
#'
#' @description AST node that represents a binary operation (such as '+', '-' etc.), and therefore having two child nodes.
#'
#' @family parser items
#' @docType class
#' @import R6
BinaryOpNode <- R6::R6Class(
  "BinaryOpNode",
  inherit = Node,
  public = list(
    
    #' @description Two children
    #' @param val Child Node
    add_child = function(val) {
      if (length(self$children)>1)
        stop("Binary operator node has only two operands")
      super$add_child(val)
    },
    
    #' @description Get the string representation of the BinaryOpNode
    to_string = function() {
      paste0(self$children[[1]]$to_string(), ifelse(self$name %in% c("^", ":"), self$name, paste0(" ", self$name, " ")), self$children[[2]]$to_string())
    }
  )
)


#' @title Range AST node
#'
#' @description AST node that represents a range of values (such as <min expression>:<max expression>), therefore having two child nodes.
#'
#' @family parser items
#' @docType class
#' @import R6
RangeNode <- R6::R6Class(
  "RangeNode",
  inherit = Node,
  public = list(
    
    #' @description Two children
    #' @param val Child Node
    add_child = function(val) {
      if (length(self$children)>1)
        stop("Range node has only two operands")
      super$add_child(val)
    },
    
    #' @description Get the string representation of the BinaryOpNode
    to_string = function() {
      paste0(self$children[[1]]$to_string(), ":", self$children[[2]]$to_string())
    }
  )
)
#' @title Group AST node
#'
#' @description AST node that reprsents a group of tokens enclosed by parenthesis.
#'
#' @family parser items
#' @docType class
#' @import R6
#' @export
GroupNode <- R6::R6Class(
  "GroupNode",
  inherit = Node,
  public = list(
    
    #' @description Get the string representation of the GroupNode
    to_string = function() {
      str <- "("
      if (!is.null(self$children)) {
        for (i in 1:length(self$children)) {
          child <- self$children[[i]]
          if (!is.null(child)) {
            if (i>1)
              str <- paste0(str, ", ")
            str <- paste0(str, child$to_string())
          }
        }
      }
      paste0(str, ")")
    }
  )
)
