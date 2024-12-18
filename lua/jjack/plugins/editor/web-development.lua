return {
    { -- emmet for my config. might look for a lua alternative in future
        "mattn/emmet-vim",
        ft = { "php", "html", "css" },
        config = function()
            -- Keybindings for Emmet
            vim.api.nvim_set_keymap('i', '<C-E>', '<Plug>(emmet-expand-abbr)', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('n', '<C-E>', '<Plug>(emmet-expand-abbr)', { noremap = false, silent = true })
        end
    }
}

