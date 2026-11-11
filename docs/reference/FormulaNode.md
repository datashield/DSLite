# Formula AST node

AST node that reprsents a formula (such as NAME ~ *terms*).

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
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
`FormulaNode`

## Methods

### Public methods

- [`FormulaNode$add_child()`](#method-FormulaNode-add_child)

- [`FormulaNode$to_string()`](#method-FormulaNode-to_string)

- [`FormulaNode$clone()`](#method-FormulaNode-clone)

Inherited methods

- [`Node$accept()`](https://datashield.github.io/DSLite/reference/Node.html#method-accept)
- [`Node$initialize()`](https://datashield.github.io/DSLite/reference/Node.html#method-initialize)
- [`Node$set_parent()`](https://datashield.github.io/DSLite/reference/Node.html#method-set_parent)
- [`Node$to_string_children()`](https://datashield.github.io/DSLite/reference/Node.html#method-to_string_children)

------------------------------------------------------------------------

### `FormulaNode$add_child()`

Two children

#### Usage

    FormulaNode$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `FormulaNode$to_string()`

Get the string representation of the BinaryOpNode

#### Usage

    FormulaNode$to_string()

------------------------------------------------------------------------

### `FormulaNode$clone()`

The objects of this class are cloneable with this method.

#### Usage

    FormulaNode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
