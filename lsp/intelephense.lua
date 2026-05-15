---@type vim.lsp.Config
return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { '.git', 'composer.json' },
  ---@type lspconfig.settings.intelephense
  settings = {
    intelephense = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
