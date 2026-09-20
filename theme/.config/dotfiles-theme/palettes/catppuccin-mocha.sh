# Catppuccin Mocha. Palette from Ghostty's bundled "Catppuccin Mocha" theme.
label="Catppuccin Mocha"
mode="dark"
background="#1e1e2e"
foreground="#cdd6f4"
cursor="#f5e0dc"
selection_background="#585b70"
selection_foreground="#cdd6f4"

palette=(
    "#45475a"
    "#f38ba8"
    "#a6e3a1"
    "#f9e2af"
    "#89b4fa"
    "#f5c2e7"
    "#94e2d5"
    "#a6adc8"
    "#585b70"
    "#f37799"
    "#89d88b"
    "#ebd391"
    "#74a8fc"
    "#f2aede"
    "#6bd7ca"
    "#bac2de"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "mocha" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },
LUA
