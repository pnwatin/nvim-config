-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "clear current search" })
vim.keymap.set(
  "n",
  "<leader>ru",
  ":TypescriptRemoveUnused<CR>",
  { noremap = true, silent = true, desc = "remove unused variables" }
)

if Util.has("bufferline.nvim") then
  vim.keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  vim.keymap.set("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

vim.keymap.set("n", "<C-x>", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<leader><C-X>", function()
  require("mini.bufremove").delete(0, true)
end, { desc = "Delete Buffer (Force)" })
