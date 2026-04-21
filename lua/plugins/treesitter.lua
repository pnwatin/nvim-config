return {
  {
    "windwp/nvim-ts-autotag",
    name = "auto-tag",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
    version = false,
    lazy = false,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall", "TSUpdateSync" },
    ---@type TSConfig
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "dockerfile",
        "git_config",
        "gitcommit",
        "git_rebase",
        "gitignore",
        "gitattributes",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "prisma",
        "python",
        "query",
        "regex",
        "ron",
        "rust",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      vim.keymap.set({ "n", "x" }, "<C-Space>", function()
        if vim.api.nvim_get_mode().mode == "n" then
          vim.cmd("normal! v")
        end

        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require("vim.treesitter._select").select_parent(vim.v.count1)
        else
          vim.lsp.buf.selection_range(vim.v.count1)
        end
      end, { desc = "Increment Selection" })
      vim.keymap.set("x", "<BS>", function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require("vim.treesitter._select").select_child(vim.v.count1)
        else
          vim.lsp.buf.selection_range(-vim.v.count1)
        end
      end, { desc = "Decrement Selection" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    },
    init = function()
      vim.g.no_plugin_maps = true
    end,
  },
}
