return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "stylua",
        -- "rome",
        "shfmt",
        "emmet-ls",
        "sqlls",
        "lua-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",
        "yaml-language-server",
        "rust-analyzer",
        "codelldb",
        "prisma-language-server",
      },
      ui = { border = "rounded" },
    },
  },
}