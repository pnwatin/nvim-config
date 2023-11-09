return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        prismals = {},
        rust_analyzer = {
          keys = {
            { "<leader>ca", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
          },
        },
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
