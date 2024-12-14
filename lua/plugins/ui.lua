return {
  {
    "lukas-reineke/virt-column.nvim",
    opts = {
      char = { "╎" },
      virtcolumn = "100",
      highlight = { "EndOfBuffer" },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
        bottom_search = false,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
        globalstatus = true,
      },
      sections = { lualine_z = {} },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      show_end_of_buffer = true,
      color_overrides = {
        mocha = {
          base = "#11111b",
          mantle = "#11111b",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>.",
        false,
      },
      {
        "<leader>S",
        false,
      },
      {
        "<leader>dps",
        false,
      },
    },
    opts = {
      dashboard = {
        enabled = false,
      },
      scratch = { enabled = false },
      scroll = { enabled = false },
      indent = {
        indent = {
          char = "╎",
          hl = "EndOfBuffer",
        },
        animate = { enabled = false },
        scope = { char = "╎", hl = "ModeMsg" },
      },
      lazygit = {
        win = {
          border = "rounded",
        },
      },
    },
  },
}
