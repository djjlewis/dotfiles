# Gruvbox Light Medium. Palette from Ghostty's bundled "Gruvbox Light" theme.
label="Gruvbox Light Medium"
mode="light"
background="#fbf1c7"
foreground="#3c3836"
cursor="#3c3836"
selection_background="#3c3836"
selection_foreground="#fbf1c7"

palette=(
    "#fbf1c7"
    "#cc241d"
    "#98971a"
    "#d79921"
    "#458588"
    "#b16286"
    "#689d6a"
    "#7c6f64"
    "#928374"
    "#9d0006"
    "#79740e"
    "#b57614"
    "#076678"
    "#8f3f71"
    "#427b58"
    "#3c3836"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "ellisonleao/gruvbox.nvim",
    opts = { contrast = "" },
    init = function()
      vim.o.background = "light"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },
LUA
