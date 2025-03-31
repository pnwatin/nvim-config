-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = "~",
}

opt.wrap = true
opt.conceallevel = 0
opt.number = true
opt.relativenumber = true

opt.softtabstop = 2
opt.scrolloff = 99999
opt.sidescrolloff = 15

opt.foldenable = false
opt.foldnestmax = 1

opt.iskeyword:append("-")

-- vim.g.lazyvim_blink_main = true
vim.g.lazyvim_picker = "fzf"
vim.g.ai_cmp = false
vim.g.lazyvim_eslint_auto_format = true
