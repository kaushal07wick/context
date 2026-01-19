# context

`context` is a small command-line tool and Rust library that builds a structured, machine-readable index of a code repository.

It is designed to be run inside a repository and to produce a stable representation of what exists in the codebase and how it connects.

## Installation

### From crates.io

If Rust is already installed:

```bash
cargo install context
````

Verify the installation:

```bash
context --version
```

### Install via script

For environments where Cargo is not already set up:

```bash
curl -fsSL https://raw.githubusercontent.com/kaushal07wick/context/master/install.sh | sh
```

The script downloads a prebuilt binary and installs it into a standard location.
It prints guidance if the install directory is not on your `PATH`.

The script is intentionally simple and can be reviewed before running.

### Build from source

```bash
git clone https://github.com/kaushal07wick/context.git
cd context
cargo build --release
```

The compiled binary will be located at:

```bash
./target/release/context
```

## Usage

Change into any repository you want to index:

```bash
cd path/to/repo
context
```

On first run, this creates:

```
.context/
  ├─ context.json
  └─ meta.json
```

On subsequent runs, existing metadata is reused when possible.

## Command-line interface

`context` follows standard CLI conventions:

```bash
context --help
context --version
```

## What is indexed

### Files

For each supported source file:

* Path
* Language
* Size in bytes
* Line count

### Symbols

For each discovered symbol:

* Kind (for example, `function` or `class`)
* Name
* Source file
* Parameters and parameter types, when available
* Return type, when available
* Docstring or documentation comments
* Source line range

### Relationships

* Calls made by each symbol
* Calls to symbols defined within the same repository
* Calls to language builtins, standard libraries, or external packages
* Reverse call relationships (`called_by`)

## Supported languages

Currently supported:

* Python
* Rust

Each language is indexed using its own syntax and structural rules.

## Incremental behavior

`context` is safe to run repeatedly.

On each invocation it:

1. Recomputes repository statistics
2. Compares them against stored metadata
3. Reuses existing context when unchanged
4. Reindexes only what has changed when necessary

This keeps runs predictable and relatively fast.

## Library usage

The indexing logic is also available as a Rust library:

```rust
use context::load_or_build;

let ctx = load_or_build(repo_root);
```

The command-line tool uses the same API internally.

## Intended use

`context` is intended as infrastructure.

It is designed to be consumed by tools such as:

* Code-aware agents
* Refactoring and editing systems
* Review and analysis tools
* Editor and IDE integrations

It provides a structured view of a codebase without making assumptions about how that information is used.

## Summary

* `context` is a CLI tool
* It can be run in any repository
* It produces a deterministic semantic index
* Other tools consume that index

For tools that need structured access to a codebase without repeatedly scanning it, `context` is meant to be a starting point.