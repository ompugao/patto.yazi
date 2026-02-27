# patto.yazi

A [yazi](https://github.com/sxyazi/yazi) previewer plugin for [patto](https://github.com/ompugao/patto) `.pn` note files.

Renders `.pn` files with ANSI-coloured output using `patto-cli-renderer`.

## Requirements

- [yazi](https://github.com/sxyazi/yazi) ≥ 26.1.22
- [`patto-cli-renderer`](https://github.com/ompugao/patto) installed (via `cargo install --path . --bin patto-cli-renderer`)

## Installation

```sh
ya pkg add ompugao/patto
```

Then add to `~/.config/yazi/yazi.toml`:

```toml
[plugin]
prepend_previewers = [
  { url = "*.pn", run = "patto" },
]
```

> **Note:** The GitHub repository for this plugin must be named `patto.yazi` for `ya pkg add ompugao/patto` to resolve correctly.

## Manual installation

```sh
cp -r patto.yazi ~/.config/yazi/plugins/
```
