# Catppuccin Latte. Palette from Ghostty's bundled "Catppuccin Latte" theme.
label="Catppuccin Latte"
mode="light"
background="#eff1f5"
foreground="#4c4f69"
cursor="#dc8a78"
selection_background="#acb0be"
selection_foreground="#4c4f69"

palette=(
    "#5c5f77"
    "#d20f39"
    "#40a02b"
    "#df8e1d"
    "#1e66f5"
    "#ea76cb"
    "#179299"
    "#acb0be"
    "#6c6f85"
    "#de293e"
    "#49af3d"
    "#eea02d"
    "#456eff"
    "#fe85d8"
    "#2d9fa8"
    "#bcc0cc"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "latte" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-latte" },
  },
LUA
