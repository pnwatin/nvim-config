local function augroup(name)
  return vim.api.nvim_create_augroup("pnwatin_" .. name, { clear = true })
end

-- Add some callbacks to Oil actions
vim.api.nvim_create_autocmd("User", {
  group = augroup("oil-actions-callbacks"),
  pattern = "OilActionsPost",
  callback = function(args)
    if args.data.err then
      return
    end
    for _, action in ipairs(args.data.actions) do
      -- Delete buffer on Oil file deletion
      if action.type == "delete" then
        local _, path = require("oil.util").parse_url(action.url)
        local bufnr = vim.fn.bufnr(path)
        if bufnr ~= -1 then
          Snacks.bufdelete.delete(bufnr)
        end

        return
      end

      -- Snacks lsp rename on Oil file move
      if action.type == "move" then
        Snacks.rename.on_rename_file(action.src_url, action.dest_url)
        return
      end
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
