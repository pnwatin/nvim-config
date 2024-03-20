return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- inlay_hints = { enabled = true },
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
