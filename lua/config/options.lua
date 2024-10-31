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

opt.wrap = false
opt.conceallevel = 0
opt.number = true
opt.relativenumber = true
opt.numberwidth = 3

opt.softtabstop = 2
opt.scrolloff = 99999
opt.sidescrolloff = 15

opt.iskeyword:append("-")

-- opt.foldmethod = "indent"
opt.foldenable = false
opt.foldnestmax = 1
