return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    config = function()
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.enable("eslint")
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "tailwindcss",
        "prismals",
        "taplo",
        "vtsls",
        "eslint",
      },
    },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
}
