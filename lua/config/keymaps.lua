-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  "n",
  "<leader>fC",
  ':let @+ = expand("%:p:.")<CR>',
  { noremap = true, silent = true, desc = "Copy path (cwd)" }
)

-- buffers
vim.keymap.set("n", "<C-,>", ":bprev<enter>", { silent = true, desc = "Prev buffer" })
vim.keymap.set("n", "<C-.>", ":bnext<enter>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-x>", ":bdelete<enter>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader><C-x>", ":%bd|e#<enter>", { silent = true, desc = "Delete all other buffers" })
vim.keymap.set("n", "<leader>X", ":%bd!<enter>", { silent = true, desc = "Delete all buffers" })

-- terminal
vim.keymap.set("n", "<leader><CR>", "<CMD>terminal<CR>", { desc = "Terminal" })
