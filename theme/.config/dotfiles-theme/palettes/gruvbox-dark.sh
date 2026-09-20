# Gruvbox Dark Medium. Palette from Ghostty's bundled "Gruvbox Dark" theme.
label="Gruvbox Dark Medium"
mode="dark"
background="#282828"
foreground="#ebdbb2"
cursor="#ebdbb2"
selection_background="#665c54"
selection_foreground="#ebdbb2"

palette=(
    "#282828"
    "#cc241d"
    "#98971a"
    "#d79921"
    "#458588"
    "#b16286"
    "#689d6a"
    "#a89984"
    "#928374"
    "#fb4934"
    "#b8bb26"
    "#fabd2f"
    "#83a598"
    "#d3869b"
    "#8ec07c"
    "#ebdbb2"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "ellisonleao/gruvbox.nvim",
    opts = { contrast = "" },
    init = function()
      vim.o.background = "dark"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },
LUA
