return {
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
	},

	require("mason").setup(),
	require("mason-lspconfig").setup(),

	require("mason-lspconfig").setup_handlers {
		function(server_name)
			require("lspconfig")[server_name].setup {}
		end,

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
