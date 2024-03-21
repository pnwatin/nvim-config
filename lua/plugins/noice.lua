return {
  {
    "folke/noice.nvim",
    opts = {
      views = {
        split = {
          size = "30%",
        },
      },
      presets = {
        lsp_doc_border = true,
        command_palette = false,
      },
      messages = {
        view = "split",
      },
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = ":", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
        },
      },
    },
  },
}
