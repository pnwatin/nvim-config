return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      show_end_of_buffer = true,
      color_overrides = {
        mocha = {
          base = "#11111b",
          mantle = "#11111b",
        },
      },
      integrations = {
        native_lsp = {
          inlay_hints = {
            background = false,
          },
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
