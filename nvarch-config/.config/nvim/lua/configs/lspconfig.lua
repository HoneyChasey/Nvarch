vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = false},})  -- display lsp diagnostic in line for the user. Change current_line to true to display only the diagnostic when cursor is on the specific line. Only work natively with neovim >= 0.11
local servers = { "html", "cssls", "bashls", "clangd", "dockerls", "docker_compose_language_service", "gopls", "jdtls", "lua_ls", "pyright", "svelte", "nil_ls", "rust_analyzer"} -- Write here all the the name of lsp you want to enable. To get their name, please refer to https://github.com/neovim/nvim-lspconfig--

--Exemple i want to add enable svelte to my nvim go to the repo and search the name of the language.--
-- We have nvim-lspconfig/lua/lspconfig/configs/svelte.lua
                                              --^^^^^^
                                              --this IS the name you need to write in the array servers
                                              --
-- When you add a name to your servers list, Neovim looks for a file with that name in lspconfig's configs folder, reads it to know which binary to run and how to start it to import the lspconfiguration to the neovim config

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

--  rust analyser 
