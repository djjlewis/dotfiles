-- Prettier reflows prose at 120 columns and aligns tables. The lang.markdown
-- extra already routes markdown through prettier, so this only installs the
-- binary and sets the width.
--
-- markdownlint defaults to 80 columns, which made every wrapped line an
-- error, so both the linter and the formatter read a base config that moves
-- MD013 to 120. A project's own .markdownlint-cli2.yaml still overrides it.
local markdownlint_config = vim.fn.expand("~/.config/markdownlint-cli2/config.yaml")

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        -- --prose-wrap only applies to markdown. --print-width applies to
        -- every filetype prettier formats, so scope it per formatter if a
        -- web language extra ever needs a different width.
        prettier = {
          prepend_args = { "--print-width", "120", "--prose-wrap", "always" },
        },
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", markdownlint_config },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", markdownlint_config },
        },
      },
    },
  },
}
