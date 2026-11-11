# Parameter AST node

AST node that represents a function's named parameter (such as NAME =
*expression*).

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
[`GroupNode`](https://datashield.github.io/DSLite/reference/GroupNode.md),
[`Node`](https://datashield.github.io/DSLite/reference/Node.md),
[`NumericNode`](https://datashield.github.io/DSLite/reference/NumericNode.md),
[`RangeNode`](https://datashield.github.io/DSLite/reference/RangeNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`ParameterNode`

## Methods

### Public methods

- [`ParameterNode$add_child()`](#method-ParameterNode-add_child)

- [`ParameterNode$to_string()`](#method-ParameterNode-to_string)

- [`ParameterNode$clone()`](#method-ParameterNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `ParameterNode$add_child()`

Two children

#### Usage

    ParameterNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `ParameterNode$to_string()`

Get the string representation of the BinaryOpNode

#### Usage

    ParameterNode$to_string()

------------------------------------------------------------------------

### `ParameterNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    ParameterNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
