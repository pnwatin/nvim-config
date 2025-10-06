local M = { servers = {} }

M.servers.prismals = {}
M.servers.tailwindcss = {}
M.servers.dockerls = {}
M.servers.docker_compose_language_service = {}
M.servers.taplo = {}
M.servers.tinymist = {}

M.servers.eslint = {
  settings = { workingDirectories = { mode = "auto" }, format = false },
  keys = { { "<leader>ce", "<CMD>EslintFixAll<CR>", desc = "Fix all eslint diagnostics" } },
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
  keys = {
    {
      "gD",
      function()
        local params = vim.lsp.util.make_position_params(0, "utf-8")
        Util.lsp.execute({
          command = "typescript.goToSourceDefinition",
          arguments = { params.textDocument.uri, params.position },
          open = true,
        })
      end,
      desc = "Goto Source Definition",
    },
    {
      "gR",
      function()
        Util.lsp.execute({
          command = "typescript.findAllFileReferences",
          arguments = { vim.uri_from_bufnr(0) },
          open = true,
        })
      end,
      desc = "File References",
    },
    {
      "<leader>cm",
      Util.lsp.action["source.addMissingImports.ts"],
      desc = "Add missing imports",
    },
    {
      "<leader>cu",
      Util.lsp.action["source.removeUnused.ts"],
      desc = "Remove unused imports",
    },
  },
  setup = function(_, opts)
    Util.lsp.on_attach(function(client, _)
      client.commands["_typescript.moveToFileRefactoring"] = function(command, _)
        ---@diagnostic disable: assign-type-mismatch
        ---@type string, string, lsp.Range
        local action, uri, range = unpack(command.arguments)

        local function move(newf)
          client:request("workspace/executeCommand", {
            command = command.command,
            arguments = { action, uri, range, newf },
          })
        end

        local fname = vim.uri_to_fname(uri)
        client:request("workspace/executeCommand", {
          command = "typescript.tsserverRequest",
          arguments = {
            "getMoveToRefactoringFileSuggestions",
            {
              file = fname,
              startLine = range.start.line + 1,
              startOffset = range.start.character + 1,
              endLine = range["end"].line + 1,
              endOffset = range["end"].character + 1,
            },
          },
        }, function(_, result)
          ---@type string[]
          local files = result.body.files
          table.insert(files, 1, "Enter new path...")
          vim.ui.select(files, {
            prompt = "Select move destination:",
            format_item = function(f)
              return vim.fn.fnamemodify(f, ":~:.")
            end,
          }, function(f)
            if f and f:find("^Enter new path") then
              vim.ui.input({
                prompt = "Enter move destination:",
                default = vim.fn.fnamemodify(fname, ":h") .. "/",
                completion = "file",
              }, function(newf)
                if newf then
                  move(newf)
                end
              end)
            elseif f then
              move(f)
            end
          end)
        end)
      end
    end, "vtsls")
    -- copy typescript settings to javascript
    opts.settings.javascript =
      vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
  end,
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
