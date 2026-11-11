# Binary operation AST node

AST node that represents a binary operation (such as '+', '-' etc.), and
therefore having two child nodes.

## See also

Other parser items:
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
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
`BinaryOpNode`

## Methods

### Public methods

- [`BinaryOpNode$add_child()`](#method-BinaryOpNode-add_child)

- [`BinaryOpNode$to_string()`](#method-BinaryOpNode-to_string)

- [`BinaryOpNode$clone()`](#method-BinaryOpNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `BinaryOpNode$add_child()`

Two children

#### Usage

    BinaryOpNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `BinaryOpNode$to_string()`

Get the string representation of the BinaryOpNode

#### Usage

    BinaryOpNode$to_string()

------------------------------------------------------------------------

### `BinaryOpNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    BinaryOpNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
