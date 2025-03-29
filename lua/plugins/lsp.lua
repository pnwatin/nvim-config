return {
  {
    "williamboman/mason.nvim",
    keys = { { "<leader>M", vim.cmd.Mason, desc = "Mason" }, { "<leader>cm", false } },
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
        vtsls = {
          keys = {
            {
              "<leader>cm",
              LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<leader>cM",
              false,
            },
            {
              "gD",
              function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                LazyVim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end,
              desc = "File References",
            },
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>cu",
              LazyVim.lsp.action["source.removeUnusedImports"],
              desc = "Remove unused imports",
            },
            {
              "<leader>cU",
              LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused",
            },
            {
              "<leader>cD",
              LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>cV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
            {
              "<leader>ce",
              "<Cmd>EslintFixAll<CR>",
              desc = "Fix all eslint diagnostics",
            },
          },
        },
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
