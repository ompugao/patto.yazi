# patto.yazi

A [yazi](https://github.com/sxyazi/yazi) previewer plugin for [patto](https://github.com/ompugao/patto) `.pn` note files.

Renders `.pn` files with ANSI-coloured output using `patto-cli-renderer`.

## Requirements

- [yazi](https://github.com/sxyazi/yazi) ≥ 26.1.22
- [`patto-cli-renderer`](https://github.com/ompugao/patto) in `$PATH` or `$HOME/.cargo/bin/`

## Installation

```sh
ya pkg add ompugao/patto
```

> **Note:** The GitHub repository must be named `patto.yazi` for the above command to resolve correctly.

Then register the previewer with a single command:

```sh
grep -qF 'run = "patto"' ~/.config/yazi/yazi.toml || \
  printf '\n[[plugin.prepend_previewers]]\nurl = "*.pn"\nrun = "patto"\n' \
  >> ~/.config/yazi/yazi.toml
```

Or manually add to `~/.config/yazi/yazi.toml`:

```toml
[[plugin.prepend_previewers]]
url = "*.pn"
run = "patto"
```

## Manual plugin installation

```sh
cp -r patto.yazi ~/.config/yazi/plugins/
```
