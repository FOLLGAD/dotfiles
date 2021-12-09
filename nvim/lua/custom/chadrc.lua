local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.options = {
   relativenumber = true,
}

M.ui = {
  theme = "javacafe"
}

-- NvChad included plugin options & overrides
M.plugins = {
   options = {
      lspconfig = {
        setup_lspconf = "custom.plugins.lspconfig",
      },
   },
   default_plugin_config_replace = {},
}

return M
