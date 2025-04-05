return {
  {
    "saghen/blink.cmp",
    opts = {
      appearance = {
        nerd_font_variant = "mono",
      },
      fuzzy = { implementation = "rust" },
      signature = { enabled = false, window = { border = "rounded" } },
      completion = {
        accept = { dot_repeat = false, auto_brackets = { enabled = false } },
        list = {
          selection = { preselect = true },
        },
        menu = {
          max_height = 5,
          draw = {
            treesitter = {},
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = false,
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
        {
          "'",
          "'",
          suround = true,
          cond = function(fn)
            return not fn.in_lisp() or fn.in_string()
          end,
          alpha = true,
          nft = { "tex", "rust", "rs" },
          multiline = false,
        },
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
      },
    },
  },
}
