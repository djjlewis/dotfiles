-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Neovim's markdown ftplugin already teaches the internal formatter about
-- bullet and numbered lists, but it leaves textwidth at 0. Set the width
-- prettier uses, so `gwip` reflows a paragraph the same way a save does, and
-- long lines wrap as they are typed. `gq` runs prettier instead, because
-- LazyVim points formatexpr at conform.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("dotfiles_textwidth", { clear = true }),
  pattern = { "markdown", "markdown.mdx" },
  callback = function()
    vim.opt_local.textwidth = 120
  end,
})
