return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = { importModuleSpecifierPreference = "non-relative" },
        expose_as_code_action = {
          "fix_all",
          "add_missing_imports",
          "remove_unused",
        },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>TSToolsGoToSourceDefinition<CR>", desc = "TS - Go to source definition" },
      { "<leader>ai", "<cmd>TSToolsAddMissingImports<CR>", desc = "TS - Add missing imports" },
      { "<leader>rf", "<cmd>TSToolsRenameFile<CR>", desc = "TS - Rename file" },
      { "<leader>ru", "<cmd>TSToolsRemoveUnused<CR>", desc = "TS - Remove unused" },
      { "<leader>ri", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "TS - Remove unused imports" },
    },
    lazy = true,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}
