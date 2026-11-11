# Group AST node

AST node that reprsents a group of tokens enclosed by parenthesis.

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
[`Node`](https://datashield.github.io/DSLite/reference/Node.md),
[`NumericNode`](https://datashield.github.io/DSLite/reference/NumericNode.md),
[`ParameterNode`](https://datashield.github.io/DSLite/reference/ParameterNode.md),
[`RangeNode`](https://datashield.github.io/DSLite/reference/RangeNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Super class

[`Node`](https://datashield.github.io/DSLite/reference/Node.md) -\>
`GroupNode`

## Methods

### Public methods

- [`GroupNode$to_string()`](#method-GroupNode-to_string)

- [`GroupNode$clone()`](#method-GroupNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$add_child()`](https://datashield.github.io/DSLite/reference/Node.html#method-add_child)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `GroupNode$to_string()`

Get the string representation of the GroupNode

#### Usage

    GroupNode$to_string()

------------------------------------------------------------------------

### `GroupNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    GroupNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
