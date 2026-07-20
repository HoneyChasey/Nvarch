vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false}) -- display lsp diagnostic in line for the user. Change current_line to true to display only the diagnostic when cursor is on the specific line. Only work natively with neovim >= 0.11


--vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
--
vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("LspInstall " .. table.concat(servers, " "))
end, {})
