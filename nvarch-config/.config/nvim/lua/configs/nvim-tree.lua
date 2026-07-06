require("nvim-tree").setup({ -- config for auto update nvim-tree when you change current directory
 sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
}
)
