# String AST node

AST node that represent a string value, either single or double quoted.

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
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`StringNode`

## Methods

### Public methods

- [`StringNode$add_child()`](#method-StringNode-add_child)

- [`StringNode$to_string()`](#method-StringNode-to_string)

- [`StringNode$clone()`](#method-StringNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `StringNode$add_child()`

No children

#### Usage

    StringNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `StringNode$to_string()`

Get the string representation of the StringNode

#### Usage

    StringNode$to_string()

------------------------------------------------------------------------

### `StringNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    StringNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
