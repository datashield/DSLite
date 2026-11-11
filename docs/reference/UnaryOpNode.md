# Unary operator AST node

AST node that represents a unary operator (such as '-'), therefore
having a single child node.

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
[`GroupNode`](https://datashield.github.io/DSLite/reference/GroupNode.md),
[`Node`](https://datashield.github.io/DSLite/reference/Node.md),
[`NumericNode`](https://datashield.github.io/DSLite/reference/NumericNode.md),
[`ParameterNode`](https://datashield.github.io/DSLite/reference/ParameterNode.md),
[`RangeNode`](https://datashield.github.io/DSLite/reference/RangeNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`UnaryOpNode`

## Methods

### Public methods

- [`UnaryOpNode$add_child()`](#method-UnaryOpNode-add_child)

- [`UnaryOpNode$to_string()`](#method-UnaryOpNode-to_string)

- [`UnaryOpNode$clone()`](#method-UnaryOpNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `UnaryOpNode$add_child()`

One children

#### Usage

    UnaryOpNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `UnaryOpNode$to_string()`

Get the string representation of the UnaryOpNode

#### Usage

    UnaryOpNode$to_string()

------------------------------------------------------------------------

### `UnaryOpNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    UnaryOpNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
