require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto', -- auto-detects colors from current colorscheme instead of a fixed theme
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true, -- single statusline for the whole editor, avoids per-window glitches (e.g. nvim-tree)
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "nvim-tree" }, -- built-in support so lualine renders correctly for the nvim-tree window
}

-- for lualine to correctly integrate when changing theme:
-- forces a redraw of the statusline the moment :colorscheme runs (e.g. via Telescope)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    require("lualine").refresh()
  end,
})
