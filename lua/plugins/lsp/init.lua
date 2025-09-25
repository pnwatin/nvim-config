return {
  { import = "plugins.lsp.rust" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    dependencies = {
      "mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      {
        "j-hui/fidget.nvim",
        opts = { notification = {
          window = {
            winblend = 0,
          },
        } },
      },
    },
    opts = function()
      local opts = {
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = false,
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = Util.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = Util.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = Util.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = Util.icons.diagnostics.Info,
            },
          },
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = {},
        setup = {},
      }

      require("plugins.lsp.servers").register_servers(opts)

      return opts
    end,
    config = function(_, opts)
      Util.lsp.on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      Util.lsp.setup()
      Util.lsp.on_dynamic_capability(require("plugins.lsp.keymaps").on_attach)

      vim.diagnostic.config(opts.diagnostics)

      Snacks.toggle
        .new({
          name = "Diagnostics virtual text",
          get = function()
            local vt = vim.diagnostic.config().virtual_text

            return type(vt) == "table"
          end,
          set = function()
            local vt = vim.diagnostic.config().virtual_text
            if type(vt) == "table" then
              vim.diagnostic.config({ virtual_text = false })
            else
              vim.diagnostic.config({
                virtual_text = {
                  spacing = 4,
                  source = "if_many",
                  prefix = "●",
                },
              })
            end
          end,
        })
        :map("<leader>tv")

      local capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)

      vim.lsp.config("*", { capabilities })

      local mason_all = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package) or {} --[[ @as string[] ]]

      local exclude_automatic_enable = {} ---@type string[]

      local function configure(server)
        local server_opts = opts.servers[server] or {}

        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, server_opts) then
          return true -- lsp will be setup by the setup function
        end

        vim.lsp.config(server, server_opts)

        -- manually enable if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(mason_all, server) then
          vim.lsp.enable(server)
          return true
        end
        return false
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(opts.servers) do
        server_opts = server_opts == true and {} or server_opts or false
        if server_opts and server_opts.enabled ~= false then
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if configure(server) then
            exclude_automatic_enable[#exclude_automatic_enable + 1] = server
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        else
          exclude_automatic_enable[#exclude_automatic_enable + 1] = server
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_deep_extend(
          "force",
          ensure_installed,
          Util.opts("mason-lspconfig.nvim").ensure_installed or {}
        ),
        automatic_enable = {
          exclude = exclude_automatic_enable,
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = { ensure_installed = {
      "biome",
      "hadolint",
      "prettier",
      "stylua",
    } },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
}
