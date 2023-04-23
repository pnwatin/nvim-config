return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint",
        "prettierd",
        "stylua",
        "shfmt",
        "emmet_ls",
        "lua_ls",
        "tailwindcss",
        "tsserver",
        "yamlls",
        "rust_analyzer",
      },
    },
  },
}
