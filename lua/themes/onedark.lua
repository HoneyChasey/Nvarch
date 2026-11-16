-- onedarkpro.nvim ships several colorschemes, all visible in <leader>th:
--   onedark, onelight (light theme), onedark_vivid, onedark_dark
return {
  pack = { "olimorris/onedarkpro.nvim" },
  config = function()
    require("onedarkpro").setup({})
  end,
}
