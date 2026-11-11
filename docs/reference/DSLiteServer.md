# Lightweight DataSHIELD server-side component

DSLiteServer mimics a DataSHIELD server by holding datasets and exposing
DataSHIELD-like functions: aggregate and assign. A DataSHIELD session is
a R environment where the assignment and the operations happen.

## See also

Other server-side items:
[`newDSLiteServer()`](https://datashield.github.io/DSLite/reference/newDSLiteServer.md)

## Methods

### Public methods

- [`DSLiteServer$new()`](#method-DSLiteServer-initialize)

- [`DSLiteServer$config()`](#method-DSLiteServer-config)

- [`DSLiteServer$profile()`](#method-DSLiteServer-profile)

- [`DSLiteServer$strict()`](#method-DSLiteServer-strict)

- [`DSLiteServer$home()`](#method-DSLiteServer-home)

- [`DSLiteServer$workspaces()`](#method-DSLiteServer-workspaces)

- [`DSLiteServer$workspace_save()`](#method-DSLiteServer-workspace_save)

- [`DSLiteServer$workspace_restore()`](#method-DSLiteServer-workspace_restore)

- [`DSLiteServer$workspace_rm()`](#method-DSLiteServer-workspace_rm)

- [`DSLiteServer$aggregateMethods()`](#method-DSLiteServer-aggregateMethods)

- [`DSLiteServer$aggregateMethod()`](#method-DSLiteServer-aggregateMethod)

- [`DSLiteServer$assignMethods()`](#method-DSLiteServer-assignMethods)

- [`DSLiteServer$assignMethod()`](#method-DSLiteServer-assignMethod)

- [`DSLiteServer$options()`](#method-DSLiteServer-options)

- [`DSLiteServer$option()`](#method-DSLiteServer-option)

- [`DSLiteServer$newSession()`](#method-DSLiteServer-newSession)

- [`DSLiteServer$hasSession()`](#method-DSLiteServer-hasSession)

- [`DSLiteServer$getSession()`](#method-DSLiteServer-getSession)

- [`DSLiteServer$getSessionIds()`](#method-DSLiteServer-getSessionIds)

- [`DSLiteServer$getSessionData()`](#method-DSLiteServer-getSessionData)

- [`DSLiteServer$closeSession()`](#method-DSLiteServer-closeSession)

- [`DSLiteServer$tableNames()`](#method-DSLiteServer-tableNames)

- [`DSLiteServer$hasTable()`](#method-DSLiteServer-hasTable)

- [`DSLiteServer$resourceNames()`](#method-DSLiteServer-resourceNames)

- [`DSLiteServer$hasResource()`](#method-DSLiteServer-hasResource)

- [`DSLiteServer$symbols()`](#method-DSLiteServer-symbols)

- [`DSLiteServer$symbol_rm()`](#method-DSLiteServer-symbol_rm)

- [`DSLiteServer$assignTable()`](#method-DSLiteServer-assignTable)

- [`DSLiteServer$assignResource()`](#method-DSLiteServer-assignResource)

- [`DSLiteServer$assignExpr()`](#method-DSLiteServer-assignExpr)

- [`DSLiteServer$aggregate()`](#method-DSLiteServer-aggregate)

- [`DSLiteServer$clone()`](#method-DSLiteServer-clone)

------------------------------------------------------------------------

### `DSLiteServer$new()`

Create new DSLiteServer instance. See
[defaultDSConfiguration](https://datashield.github.io/DSLite/reference/defaultDSConfiguration.md)
function for including or excluding packages when discovering the
DataSHIELD configuration from the DataSHIELD server-side packages
(meta-data from the DESCRIPTION files).

#### Usage

    DSLiteServer$new(
      tables = list(),
      resources = list(),
      config = DSLite::defaultDSConfiguration(),
      strict = TRUE,
      home = file.path(tempdir(), ".dslite"),
      profile = "default"
    )

#### Arguments

- `tables`:

  A named list of data.frames representing the harmonized tables.

- `resources`:

  A named list of `resourcer::Resource` objects representing accessible
  data or computation resources.

- `config`:

  The DataSHIELD configuration. Default is to discover it from the
  DataSHIELD server-side R packages.

- `strict`:

  Logical to specify whether the DataSHIELD configuration must be
  strictly applied. Default is TRUE.

- `home`:

  Folder location where are located the session work directory and where
  to read and dump workspace images.

- `profile`:

  The DataSHIELD profile name, used to give a name to the DS
  configuration. Default is "default". Default is in a hidden folder of
  the R session's temporary directory.

#### Returns

A DSLiteServer object

------------------------------------------------------------------------

### `DSLiteServer$config()`

Get or set the DataSHIELD configuration.

#### Usage

    DSLiteServer$config(value)

#### Arguments

- `value`:

  The DataSHIELD configuration: aggregate/assign methods in data frames
  and a named list of options.

#### Returns

The DataSHIELD configuration, if no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$profile()`

Get or set the DataSHIELD profile name.

#### Usage

    DSLiteServer$profile(value)

#### Arguments

- `value`:

  The DataSHIELD profile name.

#### Returns

The DataSHIELD profile, if no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$strict()`

Get or set the level of strictness (stop when function call is not
configured)

#### Usage

    DSLiteServer$strict(value)

#### Arguments

- `value`:

  The `strict` logical field.

#### Returns

The strict field if no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$home()`

Get or set the home folder location where are located the session work
directories and where to read and dump workspace images.

#### Usage

    DSLiteServer$home(value)

#### Arguments

- `value`:

  The path to the home folder.

#### Returns

The home folder path if no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$workspaces()`

List the saved workspaces in the `home` folder.

#### Usage

    DSLiteServer$workspaces(prefix = NULL)

#### Arguments

- `prefix`:

  Filter workspaces starting with provided prefix (optional).

------------------------------------------------------------------------

### `DSLiteServer$workspace_save()`

Save the session's workspace image identified by the `sid` identifier
with the provided `name` in the `home` folder.

#### Usage

    DSLiteServer$workspace_save(sid, name)

#### Arguments

- `sid, `:

  Session ID

- `name`:

  The name to be given to the workspace's image.

------------------------------------------------------------------------

### `DSLiteServer$workspace_restore()`

Restore a saved session's workspace image into the session identified by
the `sid` identifier with the provided `name` in the `home` folder.

#### Usage

    DSLiteServer$workspace_restore(sid, name)

#### Arguments

- `sid, `:

  Session ID

- `name`:

  The name of the workspace's image to restore.

------------------------------------------------------------------------

### `DSLiteServer$workspace_rm()`

Remove the workspace image with the provided `name` from the `home`
folder.

#### Usage

    DSLiteServer$workspace_rm(name)

#### Arguments

- `name`:

  The name of the workspace.

------------------------------------------------------------------------

### `DSLiteServer$aggregateMethods()`

Get or set the aggregate methods.

#### Usage

    DSLiteServer$aggregateMethods(value)

#### Arguments

- `value`:

  A `data.frame` with columns: `name` (the client function call),
  `value` (the translated server call), `package` (relevant when
  extracted from a DataSHIELD server-side package), `version` (relevant
  when extracted from a DataSHIELD server-side package), `type`
  ("aggregate"), `class` ("function" for package functions or "script"
  for custom scripts).

#### Returns

The aggregate methods when no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$aggregateMethod()`

Get or set an aggregate method.

#### Usage

    DSLiteServer$aggregateMethod(name, value)

#### Arguments

- `name`:

  The client function call.

- `value`:

  The translated server call: either a package function reference or
  function expression. Remove the method when `NULL`.

#### Returns

The aggregate method when no `value` parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$assignMethods()`

Get or set the assign methods.

#### Usage

    DSLiteServer$assignMethods(value)

#### Arguments

- `value`:

  A `data.frame` with columns: `name` (the client function call),
  `value` (the translated server call), `package` (relevant when
  extracted from a DataSHIELD server-side package), `version` (relevant
  when extracted from a DataSHIELD server-side package), `type`
  ("assign"), `class` ("function" for package functions or "script" for
  custom scripts).

#### Returns

The assign methods when no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$assignMethod()`

Get or set an assign method.

#### Usage

    DSLiteServer$assignMethod(name, value)

#### Arguments

- `name`:

  The client function call

- `value`:

  The translated server call: either a package function reference or
  function expression. Remove the method when `NULL`.

#### Returns

The assign method when no `value` parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$options()`

Get or set the DataSHIELD R options that are applied when a new
DataSHIELD session is started.

#### Usage

    DSLiteServer$options(value)

#### Arguments

- `value`:

  A named list of options.

#### Returns

The R options when no parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$option()`

Get or set a R option.

#### Usage

    DSLiteServer$option(key, value)

#### Arguments

- `key`:

  The R option's name.

- `value`:

  The R option's value. Remove the option when `NULL`.

#### Returns

The R option's value when only `key` parameter is provided.

------------------------------------------------------------------------

### `DSLiteServer$newSession()`

Create a new DataSHIELD session (contained execution environment), apply
options that are defined in the DataSHIELD configuration and restore
workspace image if `restore` workspace name argument is provided.

#### Usage

    DSLiteServer$newSession(restore = NULL, profile = NULL)

#### Arguments

- `restore`:

  The workspace image to be restored (optional).

- `profile`:

  The requested profile name (optional). If provided, new session
  creation will fail in case it does not match the server's profile
  name.

------------------------------------------------------------------------

### `DSLiteServer$hasSession()`

Check a DataSHIELD session is alive.

#### Usage

    DSLiteServer$hasSession(sid)

#### Arguments

- `sid`:

  The session ID.

------------------------------------------------------------------------

### `DSLiteServer$getSession()`

Get the DataSHIELD session's environment.

#### Usage

    DSLiteServer$getSession(sid)

#### Arguments

- `sid`:

  The session ID.

------------------------------------------------------------------------

### `DSLiteServer$getSessionIds()`

Get the DataSHIELD session IDs.

#### Usage

    DSLiteServer$getSessionIds()

------------------------------------------------------------------------

### `DSLiteServer$getSessionData()`

Get the symbol value from the DataSHIELD session's environment.

#### Usage

    DSLiteServer$getSessionData(sid, symbol)

#### Arguments

- `sid`:

  The session ID.

- `symbol`:

  The symbol name.

------------------------------------------------------------------------

### `DSLiteServer$closeSession()`

Destroy DataSHIELD session and save workspace image if `save` workspace
name argument is provided.

#### Usage

    DSLiteServer$closeSession(sid, save = NULL)

#### Arguments

- `sid`:

  The session ID.

- `save`:

  The name of the workspace image to be saved (optional).

------------------------------------------------------------------------

### `DSLiteServer$tableNames()`

List the names of the tables that can be assigned.

#### Usage

    DSLiteServer$tableNames()

------------------------------------------------------------------------

### `DSLiteServer$hasTable()`

Check a table exists.

#### Usage

    DSLiteServer$hasTable(name)

#### Arguments

- `name`:

  The table name to be looked for.

------------------------------------------------------------------------

### `DSLiteServer$resourceNames()`

List the names of the resources (`resourcer::Resource` objects) that can
be assigned.

#### Usage

    DSLiteServer$resourceNames()

------------------------------------------------------------------------

### `DSLiteServer$hasResource()`

Check a resource (`resourcer::Resource` object) exists.

#### Usage

    DSLiteServer$hasResource(name)

#### Arguments

- `name`:

  The resource name to be looked for.

------------------------------------------------------------------------

### `DSLiteServer$symbols()`

List the symbols living in a DataSHIELD session.

#### Usage

    DSLiteServer$symbols(sid)

#### Arguments

- `sid`:

  The session ID.

------------------------------------------------------------------------

### `DSLiteServer$symbol_rm()`

Remove a symbol from a DataSHIELD session.

#### Usage

    DSLiteServer$symbol_rm(sid, name)

#### Arguments

- `sid`:

  The session ID.

- `name`:

  The symbol name.

------------------------------------------------------------------------

### `DSLiteServer$assignTable()`

Assign a table to a symbol in a DataSHIELD session. Filter table columns
with the variables names provided.

#### Usage

    DSLiteServer$assignTable(sid, symbol, name, variables = NULL, id.name = NULL)

#### Arguments

- `sid`:

  The session ID.

- `symbol`:

  The symbol to be assigned.

- `name`:

  The table's name.

- `variables`:

  The variable names to be filtered in (optional).

- `id.name`:

  The column name to be used for the entity's identifier (optional).

------------------------------------------------------------------------

### `DSLiteServer$assignResource()`

Assign a resource as a
[`resourcer::ResourceClient`](https://www.obiba.org/resourcer/reference/ResourceClient.html)
object to a symbol in a DataSHIELD session.

#### Usage

    DSLiteServer$assignResource(sid, symbol, name)

#### Arguments

- `sid`:

  The session ID.

- `symbol`:

  The symbol name.

- `name`:

  The name of the resource.

------------------------------------------------------------------------

### `DSLiteServer$assignExpr()`

Evaluate an assignment expression in a DataSHIELD session.

#### Usage

    DSLiteServer$assignExpr(sid, symbol, expr)

#### Arguments

- `sid`:

  The session ID.

- `symbol`:

  The symbol name.

- `expr`:

  The R expression to evaluate.

------------------------------------------------------------------------

### `DSLiteServer$aggregate()`

Evaluate an aggregate expression in a DataSHIELD session.

#### Usage

    DSLiteServer$aggregate(sid, expr)

#### Arguments

- `sid`:

  The session ID.

- `expr`:

  The R expression to evaluate.

------------------------------------------------------------------------

### `DSLiteServer$clone()`

The objects of this class are cloneable with this method.

#### Usage

    DSLiteServer$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
