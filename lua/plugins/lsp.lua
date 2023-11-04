return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {},
        html = {
          filetypes = {
            "html",
            "htmldjango",
          },
        },
        htmx = {
          filetypes = {
            "htmldjango",
            "html",
          },
        },
      },
    },
  },
}
