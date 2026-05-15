-- General Configuration

local opt = vim.opt

opt.termguicolors = true
opt.signcolumn = "yes:1"
opt.ignorecase = true
opt.swapfile = false
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.number = true
opt.wrap = false
opt.completeopt = { "menuone", "popup", "noinsert" }
opt.autocomplete = true
opt.winborder = "rounded"

vim.cmd.filetype("plugin indent on")
