local none_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    none_ls.builtins.formatting.gofumpt,
    -- none_ls.builtins.formatting.black,
    none_ls.builtins.diagnostics.mypy.with({
	    extra_args = function()
	    local virtual = os.getenv("CONDA_PREFIX") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
	    return { "--python-executable", virtual .. "/bin/python3", "--ignore-missing-imports", }
	    end,
	  }),
    none_ls.builtins.diagnostics.ruff,
    none_ls.builtins.formatting.goimports_reviser,
    none_ls.builtins.formatting.golines,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
return opts
