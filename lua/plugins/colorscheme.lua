return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      show_end_of_buffer = true,
      color_overrides = {
        mocha = {
          base = "#11111b",
          mantle = "#11111b",
          crust = "#11111b",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
