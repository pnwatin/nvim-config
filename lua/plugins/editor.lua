return {
  { "dstein64/vim-startuptime" },
  {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release -p fff-nvim",
    lazy = false,
    keys = {
      {
        "<leader><space>",
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
      {
        "<leader>g",
        function()
          require("fff").live_grep()
        end,
        desc = "FFFind grep",
      },
    },
    opts = {
      debug = {
        enabled = false,
        show_scores = false,
      },
      prompt = "> ",
      prompt_vim_mode = true,
      grep = { modes = { "fuzzy", "regex", "plain" } },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          require("oil").open(nil)
        end,
        desc = "Open oil",
        silent = true,
      },
      {
        "<leader>E",
        function()
          require("oil").open(vim.fn.getcwd())
        end,
        desc = "Open oil (cwd)",
        silent = true,
      },
    },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      preview_win = {
        preview_method = "scratch",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".."
        end,
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
