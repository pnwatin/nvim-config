return {
  { "bluz71/vim-nightfly-colors", name = "nightfly" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
