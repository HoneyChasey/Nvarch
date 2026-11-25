require("noice").setup({
  presets = {
    bottom_search = true,
  },
  routes = {
    -- Hide yank / paste / undo messages ("3 lines yanked", "5 more lines", "2 fewer lines", ...)
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+ lines? yanked" },
          { find = "block of %d+ lines? yanked" },
          { find = "%d+ more lines?" },
          { find = "%d+ fewer lines?" },
          { find = "%d+ lines? less" },
          { find = "%d+ lines? moved" },
          { find = "%d+ lines? indented" },
          { find = "%d+ lines? [<>]ed %d+ times?" },
          { find = "%d+ changes?; before #%d+" },
          { find = "%d+ changes?; after #%d+" },
        },
      },
      opts = { skip = true },
    },
  },
})
