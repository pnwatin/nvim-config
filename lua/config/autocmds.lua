-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Define `rustx` as a subtype of `rust`
-- set it with // vim: filetype=rustx
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rustx",
  callback = function()
    vim.bo.filetype = "rust"
  end,
})

-- Delete lazyvim default auto command that enable wrap and spell options in text files
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
