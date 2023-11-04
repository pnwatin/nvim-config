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
          format = {
            templating = true,
            wrapLineLength = 80,
            wrapAttributes = "auto",
          },
          hover = {
            documentation = true,
            references = true,
          },
        },
      },
    },
  },
}
