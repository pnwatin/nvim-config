return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      -- flavour = "latte",
      -- flavour = "frappe",
      -- flavour = "macchiato",
      flavour = "mocha",
      show_end_of_buffer = true,
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
