-- Small helpers used by both plugin specs.
local function has_lang(lang)
  return lang and vim.tbl_contains(require("nvim-treesitter").get_installed(), lang)
end

-- Query lookup can error when a language has no query for that feature yet.
local function has_query(lang, query)
  local ok, parsed = pcall(vim.treesitter.query.get, lang, query)
  return ok and parsed ~= nil
end

-- Neovim 0.12 moved incremental selection into core.
-- These wrappers keep the old Ctrl-Space / Backspace workflow.
local function select_parent()
  if vim.api.nvim_get_mode().mode == "n" then
    vim.cmd("normal! v")
  end

  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end

local function select_child()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end

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
    build = function()
      local ts = require("nvim-treesitter")
      if not ts.get_installed then
        vim.schedule(function()
          vim.notify(
            "Please restart Neovim and run :TSUpdate to use the nvim-treesitter main branch.",
            vim.log.levels.ERROR
          )
        end)
        return
      end
      ts.update(nil, { summary = true })
    end,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall", "TSUpdateSync" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
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
      local ts = require("nvim-treesitter")

      if not ts.get_installed then
        vim.notify("Please update nvim-treesitter via :Lazy", vim.log.levels.ERROR)
        return
      end
      if type(opts.ensure_installed) ~= "table" then
        vim.notify("nvim-treesitter opts.ensure_installed must be a table", vim.log.levels.ERROR)
        return
      end

      opts.ensure_installed = Util.dedup(opts.ensure_installed)
      ts.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("custom_treesitter_features", { clear = true }),
        callback = function(ev)
          local ft = ev.match
          local lang = vim.treesitter.language.get_lang(ft)
          if not has_lang(lang) then
            return
          end

          if vim.tbl_get(opts, "highlight", "enable") ~= false and has_query(lang, "highlights") then
            pcall(vim.treesitter.start, ev.buf, lang)
          end

          if vim.tbl_get(opts, "indent", "enable") ~= false and has_query(lang, "indents") then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      vim.keymap.set({ "n", "x" }, "<C-Space>", select_parent, { desc = "Increment Selection" })
      vim.keymap.set("x", "<BS>", select_child, { desc = "Decrement Selection" })
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
    config = function(_, opts)
      local textobjects = require("nvim-treesitter-textobjects")
      if not textobjects.setup then
        vim.notify("Please update nvim-treesitter-textobjects via :Lazy", vim.log.levels.ERROR)
        return
      end
      textobjects.setup(opts)

      local move = require("nvim-treesitter-textobjects.move") ---@type table<string, fun(...)>
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = vim.tbl_get(opts, "move", name) ---@type table<string, string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end

      local function attach(buf)
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not vim.tbl_get(opts, "move", "enable") or not has_lang(lang) or not has_query(lang, "textobjects") then
          return
        end

        local methods = {
          "goto_next_start",
          "goto_next_end",
          "goto_previous_start",
          "goto_previous_end",
        }

        for _, method in ipairs(methods) do
          for key, query in pairs(vim.tbl_get(opts, "move", method) or {}) do
            vim.keymap.set({ "n", "x", "o" }, key, function()
              if vim.wo.diff and key:find("[cC]") then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end, {
              buffer = buf,
              silent = true,
              desc = "Treesitter " .. method,
            })
          end
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_textobjects", { clear = true }),
        callback = function(ev)
          attach(ev.buf)
        end,
      })
      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
  },
}
