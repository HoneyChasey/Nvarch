return {
  "HoneyChasey/lazydocker.nvim",
  opts = {},
  keys = {
    {
    "<leader>ld", -- or change with your mapping key
      function()
        require("lazydocker").open()
      end,
      desc = "Open Lazydocker",
    },
  },
}
