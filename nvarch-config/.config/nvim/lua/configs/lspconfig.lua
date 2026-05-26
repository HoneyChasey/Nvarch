require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "bashls", "clangd", "dockerls", "gopls", "jdtls", "lua_ls", "pyright"} -- local servers is a list of LSP server names that NvChad loops over to tell Neovim which language servers to enable and attach to your buffers. --
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

--  rust analyser 
