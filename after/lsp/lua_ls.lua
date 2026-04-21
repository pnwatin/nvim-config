local library = vim.api.nvim_get_runtime_file("lua", true)
table.insert(library, "${3rd}/luv/library")

--- @type vim.lsp.Config
return {
	settings = {
		Lua = {
			workspace = {
				library = library,
			},
		},
	},
}
