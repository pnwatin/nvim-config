require("vim._core.ui2").enable({})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

vim.g.mapleader = " "

-- disable netrw completely
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OPTIONS
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.foldlevel = 99
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true -- Ignore case
vim.opt.iskeyword:append("-")
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.showmode = true
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.timeoutlen = 1000
vim.opt.termguicolors = true -- True color support
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winborder = "rounded"
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap
vim.opt.fillchars:append({ msgsep = "-" })

-- KEYMAPS

-- BUFFERS
vim.keymap.set("n", "<leader>d", ":bd<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>D", ":bd!<CR>", { noremap = true, silent = true, desc = "Delete buffer unchecked" })

vim.keymap.set("n", "<leader>d", ":bd<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>D", ":bd!<CR>", { noremap = true, silent = true, desc = "Delete buffer unchecked" })

-- WINDOWS
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- COPY
vim.keymap.set("n", "<leader>cf", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  vim.fn.setreg("*", table.concat(lines, "\n"))

  vim.notify("Copied " .. #lines .. " lines", vim.log.levels.INFO)
end, { desc = "Copy buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>cp", function()
  local filepath = vim.fn.expand("%:p")

  if filepath == "" then
    vim.notify("No file associated with this buffer.", vim.log.levels.WARN)
    return
  end

  local relpath = vim.fn.fnamemodify(filepath, ":.")

  vim.fn.setreg("+", relpath)
  vim.fn.setreg("*", relpath)

  vim.notify("Copied file path: " .. relpath, vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Copy buffer path (cwd)" })

-- REMAPS
vim.keymap.set({ "i", "n", "s" }, "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent = true })

-- RESETS
vim.keymap.del("n", "gra")
vim.keymap.del("x", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grx")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grr")

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	ui = { border = "rounded" },
	checker = { enabled = false },
	change_detection = {
		notify = false,
	},

	spec = {
		-- COLORSCHEME
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			opts = {
				transparent_background = true,
				color_overrides = {
					mocha = {
						base = "#11111b",
						mantle = "#11111b",
					},
				},
				lsp_styles = {
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				integrations = {
					mason = true,
					blink_cmp = true,
					fidget = true,
					treesitter = true,
				},
			},
			config = function(_, opts)
				require("catppuccin").setup(opts)

				vim.cmd.colorscheme("catppuccin")
				vim.opt.fillchars:append({ msgsep = "-" })
			end,
		},
		-- FFF
		{
			"dmtrKovalenko/fff.nvim",
			build = "cargo build --release -p fff-nvim",
			opts = {
				debug = {
					enabled = true, -- we expect your collaboration at least during the beta
					show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
				},
				prompt = "> ",
				prompt_vim_mode = false,
				grep = { modes = { "fuzzy", "regex", "plain" } },
				layout = { width = 0.99, height = 0.5, anchor = "bottom_left" },
			},
			lazy = false,
			keys = {
				{
					"<leader><space>",
					function()
						require("fff").find_files()
					end,
					desc = "FFFind files",
				},
				{
					"<leader>g",
					function()
						require("fff").live_grep()
					end,
					desc = "LiFFFe grep",
				},
			},
		},
		{
			"stevearc/oil.nvim",
			lazy = false,
			keys = {
				{
					"<leader>e",
					function()
						require("oil").open(nil)
					end,
					desc = "Open oil",
					silent = true,
				},
				{
					"<leader>E",
					function()
						require("oil").open(vim.fn.getcwd())
					end,
					desc = "Open oil (cwd)",
					silent = true,
				},
			},
			opts = {
				keymaps = {
					["q"] = "actions.close",
					["<bs>"] = "actions.parent",
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, _)
						return name == ".."
					end,
				},
				preview_win = {
					preview_method = "scratch",
				},
				skip_confirm_for_simple_edits = true,
			},
		},
		-- COMPLETION
		{
			"saghen/blink.cmp",
			version = "1.*",
			build = "cargo build --release",
			opts = {
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "mono",
				},
				fuzzy = { implementation = "rust" },
				signature = { enabled = true, window = { border = "rounded" } },
				completion = {
					accept = { resolve_timeout_ms = 500, dot_repeat = false, auto_brackets = { enabled = false } },
					list = {
						selection = { preselect = true },
					},
					menu = {
						max_height = 5,
						border = "none",
						draw = {
							treesitter = {},
							columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
						},
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 200,
						window = { border = "rounded" },
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				cmdline = { enabled = false },
				keymap = {
					preset = "none",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<C-y>"] = { "select_and_accept", "fallback" },
					["<cr>"] = { "select_and_accept", "fallback" },

					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback_to_mappings" },
					["<C-n>"] = { "select_next", "fallback_to_mappings" },

					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },

					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				},
			},
		},
		-- MASON
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		-- FORMATTING
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = "ConformInfo",
			opts = {
				formatters = {
					["biome-check"] = { require_cwd = true },
				},
				formatters_by_ft = {
					lua = { "stylua" },

					markdown = { "markdownlint-cli2" },

					css = { "biome-check" },
					graphql = { "biome-check" },
					javascript = { "biome-check" },
					javascriptreact = { "biome-check" },
					json = { "biome-check" },
					jsonc = { "biome-check" },
					typescript = { "biome-check" },
					typescriptreact = { "biome-check" },
				},
				format_on_save = {
					timeout_ms = 500,
					async = false,
					quiet = false,
					lsp_format = "fallback",
				},
			},
		},
		-- TREESITTER
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate",
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"dockerfile",
					"git_config",
					"gitcommit",
					"git_rebase",
					"gitignore",
					"gitattributes",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"json5",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"printf",
					"prisma",
					"python",
					"query",
					"regex",
					"ron",
					"rust",
					"sql",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
			},
			config = function(_, opts)
				require("nvim-treesitter").setup({
					install_dir = vim.fn.stdpath("data") .. "/site",
				})

				require("nvim-treesitter").install(opts.ensure_installed)

				local function has_lang(lang)
					return lang and vim.tbl_contains(require("nvim-treesitter").get_installed(), lang)
				end

				local function has_query(lang, query)
					local ok, parsed = pcall(vim.treesitter.query.get, lang, query)
					return ok and parsed ~= nil
				end

				vim.api.nvim_create_autocmd("FileType", {
					group = vim.api.nvim_create_augroup("custom_treesitter_features", { clear = true }),
					callback = function(ev)
						local ft = ev.match
						local lang = vim.treesitter.language.get_lang(ft)
						if not has_lang(lang) then
							return
						end

						if vim.tbl_get(opts, "highlight", "enable") ~= false and has_query(lang, "highlights") then
							pcall(vim.treesitter.start, ev.buf, lang)
						end
						--
						if vim.tbl_get(opts, "indent", "enable") ~= false and has_query(lang, "indents") then
							vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end
					end,
				})

				vim.keymap.set({ "n", "x" }, "<C-Space>", function()
					if vim.api.nvim_get_mode().mode == "n" then
						vim.cmd("normal! v")
					end

					if vim.treesitter.get_parser(nil, nil, { error = false }) then
						require("vim.treesitter._select").select_parent(vim.v.count1)
					else
						vim.lsp.buf.selection_range(vim.v.count1)
					end
				end, { desc = "Increment Selection" })
				vim.keymap.set("x", "<BS>", function()
					if vim.treesitter.get_parser(nil, nil, { error = false }) then
						require("vim.treesitter._select").select_child(vim.v.count1)
					else
						vim.lsp.buf.selection_range(-vim.v.count1)
					end
				end, { desc = "Decrement Selection" })
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			event = { "BufReadPost", "BufNewFile", "BufWritePre" },
			opts = {
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			},
		},
		-- LSP
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{
					"j-hui/fidget.nvim",
					opts = { notification = {
						window = {
							winblend = 0,
						},
					} },
				},
			},
			config = function()
				vim.diagnostic.config({
					underline = true,
					update_in_insert = false,
					virtual_text = true,
					severity_sort = true,
				})

				local capabilities = require("blink.cmp").get_lsp_capabilities()

				vim.lsp.config("*", {
					capabilities = capabilities,
				})

				vim.lsp.enable("lua_ls")
				vim.lsp.enable("prismals")
				vim.lsp.enable("tailwindcss")
				vim.lsp.enable("biome")
				vim.lsp.config("tsgo", {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						typescript = {
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = false },
								parameterNames = {
									enabled = "literals",
									suppressWhenArgumentMatchesName = true,
								},
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				})
				vim.lsp.enable("tsgo")

				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(ev)
						vim.keymap.set("n", "gd", function()
							vim.lsp.buf.definition({ buf = ev.buf })
						end, { desc = "Jump to definition" })

						vim.keymap.set("n", "gD", function()
							vim.lsp.buf.declaration({ buf = ev.buf })
						end, { desc = "Jump to declaration" })

						vim.keymap.set("n", "gy", function()
							vim.lsp.buf.type_definition({ buf = ev.buf })
						end, { desc = "Jump to type definition" })

						vim.keymap.set("n", "gI", function()
							vim.lsp.buf.implementation({ buf = ev.buf })
						end, { desc = "Jump to implementation" })

						vim.keymap.set("n", "gr", function()
							vim.lsp.buf.references({ buf = ev.buf, includeDeclaration = false }, {
								on_list = function(options)
									local items = options.items

									if #items == 1 then
										local item = items[1]
										vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
									else
										vim.fn.setqflist({}, " ", options)
										vim.cmd.copen()
									end
								end,
							})
						end, { desc = "References" })

						vim.keymap.set("n", "K", function()
							vim.lsp.buf.hover({ buf = ev.buf })
						end, { desc = "Hover" })

						vim.keymap.set("i", "<C-k>", function()
							vim.lsp.buf.signature_help({ buf = ev.buf })
						end, { desc = "Signature help" })

						vim.keymap.set("n", "<leader>ca", function()
							vim.lsp.buf.code_action({ buf = ev.buf })
						end, { desc = "Code action" })

						vim.keymap.set("n", "<leader>cr", function()
							vim.lsp.buf.rename(nil, { buf = ev.buf })
						end, { desc = "Rename" })

						vim.keymap.set("n", "<leader>cR", function()
							vim.lsp.buf.rename(nil, { buf = ev.buf })
						end, { desc = "Rename" })
					end,
				})
			end,
		},
		-- RUST
		{
			"mrcjkb/rustaceanvim",
			ft = { "rust" },
			lazy = false,
			opts = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							checkOnSave = true,
							diagnostics = {
								enable = true,
							},
							procMacro = {
								enable = true,
							},
							files = {
								excludeDirs = {
									".direnv",
									".git",
									".github",
									".gitlab",
									"bin",
									"node_modules",
									"target",
									"venv",
									".venv",
								},
							},
						},
					},
				},
			},
			config = function(_, opts)
				vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
			end,
		},
		{
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			opts = {
				completion = {
					crates = {
						enabled = true,
					},
				},
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			},
		},
		-- Lua auto-configure TODO: remove
		{
			"folke/lazydev.nvim",
			ft = "lua",
			cmd = "LazyDev",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "lazy.nvim", words = { "LazyVim" } },
					{ path = "nvim-lspconfig", words = { "lspconfig.settings" } },
				},
			},
		},
		-- MINI(s)
		{
			"nvim-mini/mini.surround",
			version = false,
			lazy = false,
			opts = {},
		},
		{
			"nvim-mini/mini.icons",
			version = false,
			opts = {},
			init = function()
				package.preload["nvim-web-devicons"] = function()
					require("mini.icons").mock_nvim_web_devicons()
					return package.loaded["nvim-web-devicons"]
				end
			end,
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {},
			keys = function()
				local keys = {
					{
						"<leader>H",
						function()
							require("harpoon"):list():add()
						end,
						desc = "Harpoon File",
					},
					{
						"<leader>h",
						function()
							local harpoon = require("harpoon")
							harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded" })
						end,
						desc = "Harpoon Quick Menu",
					},
				}

				for i = 1, 9 do
					table.insert(keys, {
						"<leader>" .. i,
						function()
							require("harpoon"):list():select(i)
						end,
						desc = "Harpoon to File " .. i,
					})
				end

				return keys
			end,
		},
	},
})
