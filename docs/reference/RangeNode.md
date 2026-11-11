# Range AST node

AST node that represents a range of values (such as *min
expression*:*max expression*), therefore having two child nodes.

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
[`GroupNode`](https://datashield.github.io/DSLite/reference/GroupNode.md),
[`Node`](https://datashield.github.io/DSLite/reference/Node.md),
[`NumericNode`](https://datashield.github.io/DSLite/reference/NumericNode.md),
[`ParameterNode`](https://datashield.github.io/DSLite/reference/ParameterNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`RangeNode`

## Methods

### Public methods

- [`RangeNode$add_child()`](#method-RangeNode-add_child)

- [`RangeNode$to_string()`](#method-RangeNode-to_string)

- [`RangeNode$clone()`](#method-RangeNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `RangeNode$add_child()`

Two children

#### Usage

    RangeNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `RangeNode$to_string()`

Get the string representation of the BinaryOpNode

#### Usage

    RangeNode$to_string()

------------------------------------------------------------------------

### `RangeNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    RangeNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
