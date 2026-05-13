require "nvchad.autocmds"
local api = vim.api

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  -- Le motif correspond aux fichiers nommés 'docker-compose.yml' ou 'docker-compose.yaml'
  pattern = {
    "*docker-compose.y*ml",
  },
  -- Lorsque le motif est détecté, la fonction est exécutée
  callback = function()
    -- On force le type de fichier spécifique
    vim.bo.filetype = "yaml.docker-compose"
  end,
  desc = "Force le filetype 'yaml.docker-compose' pour Docker Compose",
})
