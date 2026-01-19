Here is the **final README**, updated to include **crates.io publishing** and a **one-line install script**, still sober and practical.

---

# context

`context` is a command-line tool and library that builds a structured semantic index of a code repository.

You run it inside a repo.
It produces a machine-readable context that other tools and agents can rely on.

---

## Installation

### From crates.io (recommended)

If you have Rust installed:

```bash
cargo install context
```

This installs the `context` binary globally.

Verify installation:

```bash
context --version
```

---

### Install via script (no Cargo knowledge required)

For users who don’t want to think about Rust internals:

```bash
curl -fsSL https://context.sh/install | sh
```

This script:

* Installs Rust if missing
* Builds `context`
* Places the binary in `$HOME/.local/bin`
* Prints next steps if the path is not on `$PATH`

(You can inspect the script before running it.)

---

### Build from source

```bash
git clone https://github.com/<org>/context.git
cd context
cargo build --release
```

Binary location:

```bash
./target/release/context
```

---

## Running

Navigate to any repository you want to index:

```bash
cd path/to/repo
context
```

On first run, this generates:

```
.context/
  ├─ context.json
  └─ meta.json
```

Subsequent runs reuse the existing context if the repository has not changed.

---

## Command-line interface

`context` behaves like a standard Unix CLI tool.

```bash
context --help
context --version
```

Example:

```bash
context --help
```

Prints usage and available options.

```bash
context --version
```

Prints the installed version.

---

## What gets indexed

### Files

* Path
* Language
* Size (bytes)
* Line count

### Symbols

* Kind (`function`, `class`)
* Name
* Source file
* Parameters and parameter types (when available)
* Return type (when available)
* Docstring / doc comment
* Source line range

### Relationships

* Calls made by the symbol
* Calls to symbols defined in this repository
* Calls to language builtins, standard library, and external packages
* Reverse call graph (`called_by`)

---

## Supported languages

Currently supported:

* Python
* Rust

Each language is indexed using language-specific syntax and semantics.

---

## Incremental behavior

`context` is safe to run repeatedly.

On each invocation:

1. Repository statistics are recomputed
2. Compared against stored metadata
3. If unchanged, the existing context is reused
4. If changed, the context is rebuilt

This keeps indexing fast and deterministic.

---

## Library usage

`context` can also be used as a Rust library:

```rust
use context::load_or_build;

let ctx = load_or_build(repo_root);
```

The CLI uses the same API internally.

---

## Intended use

`context` is infrastructure.

It is meant to be consumed by:

* Code-aware agents
* Refactoring and editing tools
* Debuggers and reviewers
* IDEs and editor integrations
* Automated code analysis systems

It provides **what exists and how it connects**, nothing more.

---

## Non-goals

`context` intentionally does **not**:

* Execute code
* Perform full type checking
* Infer runtime behavior
* Modify source files
* Generate explanations

Those belong to higher layers built on top of it.

---

## Summary

* `context` is a CLI tool
* Anyone can `context` a repository
* It produces a deterministic semantic index
* Other tools consume that index

If a tool needs structured access to a codebase without scanning everything, it should start with `context`.
