# Numeric AST node

AST node that reprsents a numeric (integer or float) value.

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
[`GroupNode`](https://datashield.github.io/DSLite/reference/GroupNode.md),
[`Node`](https://datashield.github.io/DSLite/reference/Node.md),
[`ParameterNode`](https://datashield.github.io/DSLite/reference/ParameterNode.md),
[`RangeNode`](https://datashield.github.io/DSLite/reference/RangeNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`NumericNode`

## Methods

### Public methods

- [`NumericNode$add_child()`](#method-NumericNode-add_child)

- [`NumericNode$to_string()`](#method-NumericNode-to_string)

- [`NumericNode$clone()`](#method-NumericNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `NumericNode$add_child()`

No children

#### Usage

    NumericNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `NumericNode$to_string()`

Get the string representation of the NumericNode

#### Usage

    NumericNode$to_string()

------------------------------------------------------------------------

### `NumericNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    NumericNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
