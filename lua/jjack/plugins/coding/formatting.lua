return {
	{
    		'windwp/nvim-autopairs',
    		event = "insertenter",
    		config = true
	},
	{
		'stevearc/conform.nvim',
		event = { "BufReadPre", "BufNewFile" },

		config = function ()
			local conform = require("conform")

			conform.setup({
				astyle = {"astyle"},
				lua = {"stylua"},
			})
		vim.keymap.set({"n", "v"}, "<leader>l", function ()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)"})
		end

	},
}
