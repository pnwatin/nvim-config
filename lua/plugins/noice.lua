return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
        command_palette = false,
        bottom_search = true,
        long_message_to_split = true,
      },
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = false,
          search_down = false,
          search_up = false,
          filter = false,
          lua = false,
          help = false,
        },
      },
    },
  },
}
