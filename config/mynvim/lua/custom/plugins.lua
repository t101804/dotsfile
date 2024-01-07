local cmp = require("cmp")

local plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
				"rust-analyzer",
				"gopls",
				"golines",
				"goimports",
				"tailwindcss-language-server",
				"lua-language-server",
				"typescript-language-server",
				"shfmt",
				"css-lsp",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"sbdchd/neoformat",
		event = "BufWritePre",
		config = function()
			vim.g.neoformat_enabled_javascript = { "prettier" }
			vim.g.neoformat_enabled_html = { "prettier" }
      vim.g.neoformat_enabled_python = { "prettier" }
			vim.g.neoformat_enabled_css = { "prettier" }
			vim.g.neoformat_enabled_lua = { "prettier" }
			vim.cmd([[ 
      augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
      ]])
		end,
	},
	{
		"dreamsofcode-io/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
			require("core.utils").load_mappings("dap_go")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		ft = {"go", "python"},
		opts = function()
			return require("custom.configs.none-ls")
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
			require("core.utils").load_mappings("gopher")
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		opts = function()
			return require("custom.configs.rust-tools")
		end,
		config = function(_, opts)
			require("rust-tools").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		init = function()
			require("core.utils").load_mappings("dap")
		end,
	},
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
     },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local M = require("plugins.configs.cmp")
			table.insert(M.sources, { name = "crates" })
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 13,
				open_mapping = [[<c-\>]],
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = "1",
				start_in_insert = true,
				direction = "horizontal",
			})
		end,
	},

	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		lazy = false,
		config = function()
			require("presence").setup(                {
				auto_update = true,
				neovim_image_text = "How do I exit it?",
				main_image = "file",
				log_level = "debug",
				debounce_timeout = 10,
				enable_line_number = false,
				buttons = true,
				show_time = true,
				-- Rich Presence text options
				editing_text = "Editing %s",
				file_explorer_text = "Browsing %s",
				git_commit_text = "Committing changes",
				plugin_manager_text = "Managing plugins",
				reading_text = "Reading %s",
				workspace_text = "Working on %s",
				line_number_text = "Line %s out of %s",
			})
		end,
	},
}
return plugins
