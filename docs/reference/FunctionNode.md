# Function AST node

AST node that represents a function with its arguments.

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`GroupNode`](https://datashield.github.io/DSLite/reference/GroupNode.md),
[`Node`](https://datashield.github.io/DSLite/reference/Node.md),
[`NumericNode`](https://datashield.github.io/DSLite/reference/NumericNode.md),
[`ParameterNode`](https://datashield.github.io/DSLite/reference/ParameterNode.md),
[`RangeNode`](https://datashield.github.io/DSLite/reference/RangeNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`FunctionNode`

## Methods

### Public methods

- [`FunctionNode$to_string()`](#method-FunctionNode-to_string)

- [`FunctionNode$clone()`](#method-FunctionNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$add_child()`](https://datashield.github.io/DSLite/reference/Node.html#method-add_child)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `FunctionNode$to_string()`

Get the string representation of the FunctionNode

#### Usage

    FunctionNode$to_string()

------------------------------------------------------------------------

### `FunctionNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    FunctionNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
