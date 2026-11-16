-- Shows git diff signs (added, changed, removed) in the gutter
return {
  pack = { "lewis6991/gitsigns.nvim" },
  config = function()
    require("gitsigns").setup {
      -- Git blame of the current line, shown as virtual text at the end of the line
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 0,
      },
    }
  end,
}
