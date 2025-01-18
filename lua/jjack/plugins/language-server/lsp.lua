return {
	'neovim/nvim-lspconfig',
	cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
	},
	init = function()
		-- Reserve a space in the gutter to avoid layout shift
		vim.opt.signcolumn = 'yes'
	end,
	config = function()
		-- Add cmp_nvim_lsp capabilities to lspconfig
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- Configure LSP servers using mason-lspconfig
		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = { "lua_ls", "clangd" },
		})

		-- Setup handlers for all servers
		require('mason-lspconfig').setup_handlers({
			-- Default handler for all servers
			function(server_name)
				require('lspconfig')[server_name].setup({
					capabilities = capabilities,
				})
			end,

			-- Specific configuration for lua_ls
			["lua_ls"] = function()
				require('lspconfig').lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
		})

		-- LspAttach: enable features only when a language server is active
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }

				-- Define key mappings for LSP functionality
				local buf = vim.lsp.buf
				vim.keymap.set('n', 'K', buf.hover, opts)
				vim.keymap.set('n', 'gd', buf.definition, opts)
				vim.keymap.set('n', 'gD', buf.declaration, opts)
				vim.keymap.set('n', 'gi', buf.implementation, opts)
				vim.keymap.set('n', 'go', buf.type_definition, opts)
				vim.keymap.set('n', 'gr', buf.references, opts)
				vim.keymap.set('n', 'gs', buf.signature_help, opts)
				vim.keymap.set('n', '<F2>', buf.rename, opts)
				vim.keymap.set('n', '<F4>', buf.code_action, opts)

				-- Formatting key mapping (check if client supports it)
				vim.keymap.set('n', '<F3>', function()
					if buf.format then
						buf.format({ async = true })
					else
						vim.notify("Formatting not supported by this LSP", vim.log.levels.WARN)
					end
				end, opts)
			end,
		})
	end,
}
