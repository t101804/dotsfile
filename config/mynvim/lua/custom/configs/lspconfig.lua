local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
local servers = { "html", "cssls", "clangd"}
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


lspconfig.lua_ls.setup({
  on_attach=on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
      indent_style = "space",
      indent_size = "2",
    }

      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
})

-- Without the loop, you would have to manually set up each LSP ipairs
--
lspconfig.pyright.setup({
  on_attach = on_attach,
  filetypes = {"python"},
  capabilities = (function()
            local _capabilities = vim.lsp.protocol.make_client_capabilities()
            _capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            return _capabilities
          end)(),
  settings = {
    python = {
      analysis = {
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",
      },
    },
  },
})
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

