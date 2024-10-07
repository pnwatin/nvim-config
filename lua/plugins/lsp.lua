return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      document_highlight = {
        enabled = false,
      },
      servers = {
        bashls = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, res, ...)
              local file_name = vim.fn.fnamemodify(vim.uri_to_fname(res.uri), ":t")
              if string.match(file_name, "^%.env") == nil then
                return vim.lsp.diagnostic.on_publish_diagnostics(err, res, ...)
              end
            end,
          },
        },
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
          },
        },
        prismals = {},
        emmet_language_server = {
          filetypes = {
            "rust",
          },
        },
        html = {
          filetypes = {
            "html",
            "htmldjango",
            "rust",
          },
          init_options = {
            provideFormatter = false,
          },
        },
        htmx = {
          filetypes = {
            "htmldjango",
            "html",
            "rust",
          },
        },
      },
    },
  },
}
