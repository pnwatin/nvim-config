return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      color_overrides = {
        mocha = {
          base = "#11111b",
          mantle = "#11111b",
        },
      },
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      integrations = {
        blink_cmp = true,
        fidget = true,
        fzf = true,
        gitsigns = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme("catppuccin")
      vim.opt.fillchars:append({ msgsep = "-" })
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
