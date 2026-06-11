-- Plugin for adding color to code

-- Repetition of code i know but cleanner to have file here (already implemented by Nvchad team)
return{
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- This plugin does not support lazy-loading.
  build = ':TSUpdate',

  opts = require("configs.treesitter") -- adding configuration file lua for the plugin (you can find it in plugins/treesitter)
}
