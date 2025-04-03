return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      document_highlight = {
        enabled = false,
      },
      diagnostics = {
        float = {
          border = "rounded",
        },
        virtual_text = false,
      },
      servers = {
        tailwindcss = {
          init_options = {
            userLanguages = {
              rust = "html",
            },
          },
          filetypes_include = { "rustx" },
        },
        emmet_language_server = {
          filetypes = {
            "css",
            "rustx",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "typescriptreact",
            "htmlangular",
          },
        },
        html = {
          filetypes = {
            "rustx",
            "html",
          },
          init_options = {
            provideFormatter = false,
          },
        },
      },
    },
  },
}
