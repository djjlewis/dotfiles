# Gruvbox Material Light. Palette from Ghostty's bundled "Gruvbox Material Light" theme.
label="Gruvbox Material Light"
mode="light"
background="#fbf1c7"
foreground="#654735"
cursor="#654735"
selection_background="#654735"
selection_foreground="#fbf1c7"

palette=(
    "#fbf1c7"
    "#c14a4a"
    "#6c782e"
    "#b47109"
    "#45707a"
    "#945e80"
    "#4c7a5d"
    "#654735"
    "#a89984"
    "#c14a4a"
    "#6c782e"
    "#b47109"
    "#45707a"
    "#945e80"
    "#4c7a5d"
    "#4f3829"
)

IFS= read -r -d '' nvim_lua <<'LUA' || true
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "light"
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox-material" },
  },
LUA
