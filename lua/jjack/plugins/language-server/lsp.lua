return {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
    },
    init = function()
        -- Reserve a space in the gutter to avoid layout shift
        vim.opt.signcolumn = 'yes'
    end,
    config = function()
        local lsp_defaults = require('lspconfig').util.default_config

        -- Add cmp_nvim_lsp capabilities to lspconfig
        -- This should be executed before configuring any language server
        lsp_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lsp_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- LspAttach: enable features only when a language server is active
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = {buffer = event.buf}

                -- Define key mappings for LSP functionality
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            end,
        })

	require('mason').setup({})
        -- Mason LSP configuration
        require('mason-lspconfig').setup({
            ensure_installed = {}, -- Add language servers here if needed
            handlers = {
                -- Default handler for all servers without custom handlers
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            }
        })
    end
}
