-- Config file for mason.nvim
-- Install LSPs, Linters and more automatically...
return {
	-- Installing dependencies.
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
	},

	-- Setting up mason
	-- Making sure mason-lspconfig is setup
	require("mason").setup(),
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "clangd" }
	}),

	-- Setting up handlers for mason-lspconfig
	require("mason-lspconfig").setup_handlers {
		function(server_name)
			require("lspconfig")[server_name].setup {}
		end,

		-- Configuring the Lua LSP
		["lua_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }
						}
					}
				}
			}
		end,
	}
}

