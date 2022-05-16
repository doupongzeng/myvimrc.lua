local status, nvim_tree = pcall(require, 'nvim-tree')
if not status then
  vim.notify('not found nvim-tree')
  return
end

local list_keys = require('keybindings').nvimTreeList
nvim_tree.setup({
  git = {
    enable = false,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = true,
    custom = { 'node_modules' },
  },
  view = {
    width = 40,
    side = 'left',
    -- 隐藏根目录
    hide_root_folder = false,
    mappings = {
      custom_only = false,
      list = list_keys,
    },
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
  },
  actions = {
    open_file = {
      resize_window = true,
      -- 打开文件时关闭
      quit_on_open = true,
    },
  },
  -- npm install -g wsl-open
  -- https://github.com/4U6U57/wsl-open/
  system_open = {
    cmd = 'open',
  },
})
