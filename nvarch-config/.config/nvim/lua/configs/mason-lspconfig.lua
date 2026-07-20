local servers = require("configs.servers")

return {
  require("mason-lspconfig").setup({
    ensure_installed = servers
  })
}


