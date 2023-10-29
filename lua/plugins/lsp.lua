return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opt)
      vim.list_extend(opt.servers, {
        emmet_language_server = {},
      })
    end,
  },
}
