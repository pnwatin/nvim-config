-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.guicursor = {
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = "~",
}

opt.number = true
opt.relativenumber = true
opt.numberwidth = 3

opt.softtabstop = 2
opt.scrolloff = 8

opt.iskeyword:append("-")

opt.foldmethod = "indent"
opt.foldenable = false
