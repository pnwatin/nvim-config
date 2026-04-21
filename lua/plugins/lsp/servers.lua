local M = { servers = {} }

M.servers.prismals = {}
M.servers.tailwindcss = {}
M.servers.dockerls = {}
M.servers.docker_compose_language_service = {}
M.servers.taplo = {}
M.servers.tinymist = {}

M.servers.eslint = {
  settings = { workingDirectories = { mode = "auto" }, format = false },
  keys = { { "<leader>ce", "<CMD>LspEslintFixAll<CR>", desc = "Fix all eslint diagnostics" } },
}

M.lua_ls = {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}

M.servers.jsonls = {
  -- lazy-load schemastore when needed
  before_init = function(_, new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}

M.servers.yamlls = {
  -- Have to add this for yamlls to understand that we support line folding
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  -- lazy-load schemastore when needed
  before_init = function(_, new_config)
    new_config.settings.yaml.schemas =
      vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
    },
  },
}

M.servers.emmet_language_server = {
  filetypes = {
    "css",
    "rustx",
    "eruby",
    "html",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "typescriptreact",
    "htmlangular",
  },
}

M.servers.vtsls = {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      preferences = {
        importModuleSpecifier = "non-relative",
        importModuleSpecifierEnding = "minimal",
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}

---@param opts table
function M.register_servers(opts)
  opts.servers = opts.servers or {}
  opts.setup = opts.setup or {}

  for k, v in pairs(M.servers) do
    if v.setup ~= nil then
      opts.setup[k] = v.setup
    end

    opts.servers[k] = v
  end
end

return M
