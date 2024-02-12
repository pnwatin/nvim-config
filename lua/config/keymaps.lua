-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "clear current search" })
vim.keymap.set(
  "v",
  "v/",
  "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>",
  { noremap = true, silent = true, desc = "search selected text" }
)

-- buffers
vim.keymap.set("n", "<C-,>", ":bprev<enter>", { silent = true, desc = "Prev buffer" })
vim.keymap.set("n", "<C-.>", ":bnext<enter>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-x>", ":bp|bd #<enter>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader><C-x>", ":%bd|e#<enter>", { silent = true, desc = "Delete all other buffers" })
vim.keymap.set("n", "<leader>X", ":%bd!<enter>", { silent = true, desc = "Delete all buffers" })

-- resets
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "[b")
vim.keymap.del("n", "]b")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")
