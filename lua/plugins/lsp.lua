return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    keys = { { "<leader>cm", false } },
    opts = {
      ui = { border = "rounded" },
    },
  },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
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
