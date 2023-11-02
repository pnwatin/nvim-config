return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opt)
      vim.list_extend(opt.servers, {
        emmet_language_server = {},
        html = {
          format = {
            templating = true,
            wrapLineLength = 120,
            wrapAttributes = "auto",
          },
          hover = {
            documentation = true,
            references = true,
          },
        },
      })
    end,
  },
}
