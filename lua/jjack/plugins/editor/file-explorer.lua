-- Tree-like file explorer.

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        filesystem = {
            bind_to_cwd = true,
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false, -- Optionally, you can add more options
            },
        },
    },
}
