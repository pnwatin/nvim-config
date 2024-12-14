return {
  {
    "saghen/blink.cmp",
    opts = {
      appearance = {
        nerd_font_variant = "Nerd Font Mono",
      },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
          max_height = 5,
          draw = {
            treesitter = {},
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
      },
    },
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {
      config_internal_pairs = {
        { "{", "}", suround = true, multiline = true },
        { "[", "]", suround = true, multiline = true },
        { "(", ")", suround = true, multiline = true },
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
}
