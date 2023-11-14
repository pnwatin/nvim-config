return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        prismals = {},
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
