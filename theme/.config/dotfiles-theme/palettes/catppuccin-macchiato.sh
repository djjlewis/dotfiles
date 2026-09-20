# Catppuccin Macchiato. Palette from Ghostty's bundled "Catppuccin Macchiato" theme.
label="Catppuccin Macchiato"
mode="dark"
background="#24273a"
foreground="#cad3f5"
cursor="#f4dbd6"
selection_background="#5b6078"
selection_foreground="#cad3f5"

palette=(
    "#494d64"
    "#ed8796"
    "#a6da95"
    "#eed49f"
    "#8aadf4"
    "#f5bde6"
    "#8bd5ca"
    "#a5adcb"
    "#5b6078"
    "#ec7486"
    "#8ccf7f"
    "#e1c682"
    "#78a1f6"
    "#f2a9dd"
    "#63cbc0"
    "#b8c0e0"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "macchiato" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-macchiato" },
  },
LUA
