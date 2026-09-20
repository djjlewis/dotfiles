# Neovim

The `nvim` package is the [LazyVim](https://www.lazyvim.org) starter with one
extra enabled, `lang.markdown`. LazyVim's own
[keymaps](https://www.lazyvim.org/keymaps) apply. The leader is `Space`, and
`Space` on its own shows what is bound.

The colourscheme comes from the [theme](theme.md) command, which writes
`lua/plugins/dotfiles-theme.lua` next to the stowed files. That file is not in
the repo.

## Plugins

`:Lazy` opens the plugin manager. `lazy-lock.json` is committed, so
`:Lazy restore` puts a fresh machine on the same plugin versions.
`:LazyExtras` toggles LazyVim extras and writes `lazyvim.json`, which is
stowed, so a change there shows up in `git status`.

## Markdown

`lang.markdown` brings marksman, markdownlint-cli2, and render-markdown.nvim,
and routes formatting through prettier. `lua/plugins/markdown.lua` adds the
settings.

Prettier runs with `--print-width 120 --prose-wrap always`, so saving a
markdown file reflows prose at 120 columns and aligns table pipes. LazyVim
formats on save. `<leader>uf` turns that off for the session and `<leader>cf`
formats on demand. The 120 width also applies to any other filetype prettier
formats.

`textwidth` is 120 for markdown, so `gwip` reflows a paragraph in place and
long lines wrap as you type. Use `gw`, not `gq`. LazyVim points `gq` at
prettier, which formats the whole range. The bundled markdown ftplugin knows
about bullet and numbered lists, so `gw` leaves them intact. Turn off wrapping
as you type with `:setlocal formatoptions-=t`.

markdownlint reads `~/.config/markdownlint-cli2/config.yaml`, stowed from this
package. It raises the line length rule to 120 and skips code blocks and
tables, which prettier never breaks. A project's own `.markdownlint-cli2.yaml`
still wins.
