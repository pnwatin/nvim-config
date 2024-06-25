-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "clear current search" })

-- buffers
vim.keymap.set("n", "<C-,>", ":bprev<enter>", { silent = true, desc = "Prev buffer" })
vim.keymap.set("n", "<C-.>", ":bnext<enter>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-x>", ":bdelete<enter>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader><C-x>", ":%bd|e#<enter>", { silent = true, desc = "Delete all other buffers" })
vim.keymap.set("n", "<leader>X", ":%bd!<enter>", { silent = true, desc = "Delete all buffers" })

-- oil
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { silent = true, desc = "Open oil" })
vim.keymap.set("n", "<leader>E", function()
  require("oil.actions").open_cwd.callback()
end, { silent = true, desc = "Open oil (cwd)" })

-- terminal
vim.keymap.set("n", "<leader><CR>", "<CMD>terminal<CR>")

-- resets
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "[b")
vim.keymap.del("n", "]b")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<c-/>")
vim.keymap.del("n", "<c-_>")
vim.keymap.del("t", "<c-/>")
vim.keymap.del("t", "<c-_>")
vim.keymap.del("i", "<tab>")
vim.keymap.del("i", "<S-Tab>")
vim.keymap.del("n", "<Space><Tab>Þ")
vim.keymap.del("x", "<Space><Tab>Þ")
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")
