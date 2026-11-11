# Simple AST node

Abstract Syntaxic Tree (AST) node that will be created by the DSLite R
parser.

## See also

Other parser items:
[`BinaryOpNode`](https://datashield.github.io/DSLite/reference/BinaryOpNode.md),
[`FormulaNode`](https://datashield.github.io/DSLite/reference/FormulaNode.md),
[`FunctionNode`](https://datashield.github.io/DSLite/reference/FunctionNode.md),
[`GroupNode`](https://datashield.github.io/DSLite/reference/GroupNode.md),
[`NumericNode`](https://datashield.github.io/DSLite/reference/NumericNode.md),
[`ParameterNode`](https://datashield.github.io/DSLite/reference/ParameterNode.md),
[`RangeNode`](https://datashield.github.io/DSLite/reference/RangeNode.md),
[`StringNode`](https://datashield.github.io/DSLite/reference/StringNode.md),
[`SymbolNode`](https://datashield.github.io/DSLite/reference/SymbolNode.md),
[`UnaryOpNode`](https://datashield.github.io/DSLite/reference/UnaryOpNode.md)

## Public fields

- `name`:

  Token value

- `parent`:

  Parent Node

- `children`:

  Children Nodes

## Methods

### Public methods

- [`Node$new()`](#method-Node-initialize)

- [`Node$set_parent()`](#method-Node-set_parent)

- [`Node$add_child()`](#method-Node-add_child)

- [`Node$to_string()`](#method-Node-to_string)

- [`Node$to_string_children()`](#method-Node-to_string_children)

- [`Node$accept()`](#method-Node-accept)

- [`Node$clone()`](#method-Node-clone)

------------------------------------------------------------------------

### `Node$new()`

Simple node constructor

#### Usage

    Node$new(name = NA, parent = NA)

#### Arguments

- `name`:

  Token value

- `parent`:

  Parent Node

#### Returns

A Node object

------------------------------------------------------------------------

### `Node$set_parent()`

Set parent Node

#### Usage

    Node$set_parent(val)

#### Arguments

- `val`:

  Parent Node

------------------------------------------------------------------------

### `Node$add_child()`

Add a child Node

#### Usage

    Node$add_child(val)

#### Arguments

- `val`:

  Child Node

------------------------------------------------------------------------

### `Node$to_string()`

The string representation of the Node

#### Usage

    Node$to_string()

------------------------------------------------------------------------

### `Node$to_string_children()`

Get the string representation of the Node's children

#### Usage

    Node$to_string_children()

------------------------------------------------------------------------

### `Node$accept()`

Accept visitor

#### Usage

    Node$accept(visitor)

#### Arguments

- `visitor`:

  Node visitor object

------------------------------------------------------------------------

### `Node$clone()`

The objects of this class are cloneable with this method.

#### Usage

    Node$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
