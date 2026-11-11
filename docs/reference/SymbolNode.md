# Symbol AST node

AST node that represents a R symbol (variable name, function name etc.).

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
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`SymbolNode`

## Methods

### Public methods

- [`SymbolNode$add_child()`](#method-SymbolNode-add_child)

- [`SymbolNode$to_string()`](#method-SymbolNode-to_string)

- [`SymbolNode$clone()`](#method-SymbolNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `SymbolNode$add_child()`

No children

#### Usage

    SymbolNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `SymbolNode$to_string()`

Get the string representation of the SymbolNode

#### Usage

    SymbolNode$to_string()

------------------------------------------------------------------------

### `SymbolNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    SymbolNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
