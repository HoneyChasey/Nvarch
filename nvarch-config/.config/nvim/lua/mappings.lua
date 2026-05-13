require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Lazygit mapping 
map("n", "<leader>g", "<cmd>lua require('lazygit').lazygit()<CR>", { desc = "Open LazyGit" })
-- Telescip mapping 
map('n', '<leader>f', ':Telescope find_files<CR>')
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
