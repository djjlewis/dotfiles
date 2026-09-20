# Tokyo Night. Palette from Ghostty's bundled "TokyoNight Night" theme.
label="Tokyo Night"
mode="dark"
background="#1a1b26"
foreground="#c0caf5"
cursor="#c0caf5"
selection_background="#283457"
selection_foreground="#c0caf5"

palette=(
    "#15161e"
    "#f7768e"
    "#9ece6a"
    "#e0af68"
    "#7aa2f7"
    "#bb9af7"
    "#7dcfff"
    "#a9b1d6"
    "#414868"
    "#f7768e"
    "#9ece6a"
    "#e0af68"
    "#7aa2f7"
    "#bb9af7"
    "#7dcfff"
    "#c0caf5"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight-night" },
  },
LUA
