# Catppuccin Frappe. Palette from Ghostty's bundled "Catppuccin Frappe" theme.
label="Catppuccin Frappe"
mode="dark"
background="#303446"
foreground="#c6d0f5"
cursor="#f2d5cf"
selection_background="#626880"
selection_foreground="#c6d0f5"

palette=(
    "#51576d"
    "#e78284"
    "#a6d189"
    "#e5c890"
    "#8caaee"
    "#f4b8e4"
    "#81c8be"
    "#a5adce"
    "#626880"
    "#e67172"
    "#8ec772"
    "#d9ba73"
    "#7b9ef0"
    "#f2a4db"
    "#5abfb5"
    "#b5bfe2"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "frappe" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-frappe" },
  },
LUA
