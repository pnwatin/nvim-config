return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        -- treesitter
        { "<BS>", desc = "Decrement Selection", mode = "x" },
        { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },

        -- groups
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code" },
        { "<leader>t", group = "Toggle" },
        { "<leader>s", group = "Search" },
        { "<leader>f", group = "Find" },
        { "<leader>x", group = "Trouble" },
        { "<leader>b", group = "Buffers" },
        { "g", group = "Goto" },

        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            ---@diagnostic disable-next-line: missing-parameter, missing-fields
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            ---@diagnostic disable-next-line: missing-fields, missing-parameter
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
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
          require("oil").open(nil, { preview = { vertical = true } })
        end,
        desc = "Open oil",
        silent = true,
      },
      {
        "<leader>E",
        function()
          require("oil").open(vim.fn.getcwd(), { preview = { vertical = true } })
        end,
        desc = "Open oil (cwd)",
        silent = true,
      },
    },
    opts = {
      keymaps = {
        ["q"] = "actions.close",
        ["<bs>"] = "actions.parent",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".."
        end,
      },
      skip_confirm_for_simple_edits = true,
    },
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep (root)" },
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Files (root)" },
      -- find
      {
        "<leader>fF",
        function()
          require("fzf-lua").files({ cwd = vim.uv.cwd() })
        end,
        desc = "Files (cwd)",
      },
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files (root)" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Git files" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      {
        "<leader>fR",
        function()
          require("fzf-lua").oldfiles({ cwd = vim.uv.cwd() })
        end,
        desc = "Recent files (cwd)",
      },
      -- search
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>s:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (root)" },
      {
        "<leader>sG",
        function()
          require("fzf-lua").live_grep({ cwd = vim.uv.cwd() })
        end,
        desc = "Grep (cwd)",
      },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word (root)" },
      {
        "<leader>sW",
        function()
          require("fzf-lua").grep_cword({ cwd = vim.uv.cwd() })
        end,
        desc = "Word (cwd)",
      },
      { "<leader>sw", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "Selection (root)" },
      {
        "<leader>sW",
        function()
          require("fzf-lua").grep_visual({ cwd = vim.uv.cwd() })
        end,
        mode = "v",
        desc = "Selection (cwd)",
      },
      -- git
      {
        "<leader>gb",
        function()
          require("fzf-lua").git_blame({
            cmd = [[git blame --color-lines --date=short {file} | awk '!seen[$1]++']],
          })
        end,
        mode = { "v", "n" },
        desc = "Blame",
      },
      { "<leader>gf", "<cmd>FzfLua git_bcommits<cr>", desc = "Commits (buffer)" },
      { "<leader>gl", "<cmd>FzfLua git_commits<cr>", desc = "Commits (project)" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
    },
    opts = function()
      local fzf = require("fzf-lua")
      local config = fzf.config
      local actions = fzf.actions

      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      return {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          formatter = "path.dirname_first",
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
    config = function(_, opts)
      if opts[1] == "default-title" then
        -- use the same prompt for all pickers for profile `default-title` and
        -- profiles that use `default-title` as base profile
        local function fix(t)
          t.prompt = t.prompt ~= nil and " " or nil
          for _, v in pairs(t) do
            if type(v) == "table" then
              fix(v)
            end
          end
          return t
        end
        opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
        opts[1] = nil
      end
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghB", function()
          gs.blame()
        end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
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
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
      {
        "<leader>st",
        function()
          require("todo-comments.fzf").todo()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
}
