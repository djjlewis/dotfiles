# Gruvbox Material Dark. Palette from Ghostty's bundled "Gruvbox Material Dark" theme.
label="Gruvbox Material Dark"
mode="dark"
background="#282828"
foreground="#d4be98"
cursor="#d4be98"
selection_background="#d4be98"
selection_foreground="#282828"

palette=(
    "#282828"
    "#ea6962"
    "#a9b665"
    "#d8a657"
    "#7daea3"
    "#d3869b"
    "#89b482"
    "#d4be98"
    "#7c6f64"
    "#ea6962"
    "#a9b665"
    "#d8a657"
    "#7daea3"
    "#d3869b"
    "#89b482"
    "#ddc7a1"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox-material" },
  },
LUA
