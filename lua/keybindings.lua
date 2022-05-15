--[[
-- vim.api.nvim_set_keymap() 全局快捷键
-- vim.api.nvim_buf_set_keymap() buffer快捷键
-- vim.api.nvim_set_keymap('模式', '按键', '映射为', 'options')
-- n Normal, i Insert, v Visual, t Terminal, c Command
-- options: noremap 不会连续映射，silent 不输出多余信息
--]]

-- remap <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

------------------------------
--windows 分屏
------------------------------
-- 取消s默认功能，映射分屏
map('n', 's', "", opt)
map('n', 'sv', ':vsp<CR>', opt)
map('n', 'sh', ':sp<CR>', opt)
-- 关闭当前
map('n', 'sc', ':<C-w>c', opt)
-- 关闭其它
map('n', 'so', ':<C-w>o', opt)
-- Alt + hjkl 窗口之间跳转
map('n', '<A-h>', '<C-w>h', opt)
map('n', '<A-j>', '<C-w>j', opt)
map('n', '<A-k>', '<C-w>k', opt)
map('n', '<A-l>', '<C-w>l', opt)
-- 上下左右比例控制
map('n', '<C-Left>', ':vertical resize -2<CR>', opt)
map('n', '<C-Right>', ':vertical resize +2<CR>', opt)
map('n', 's,', ':vertical resize -20<CR>', opt)
map('n', 's.', ':vertical resize +20<CR>', opt)
map('n', '<C-Down>', ':resize +2<CR>', opt)
map('n', '<C-Up>', ':resize -2<CR>', opt)
map('n', 'sj', ':resize +10<CR>', opt)
map('n', 'sk', ':resize -10<CR>', opt)
map('n', 's=', '<C-w>=', opt)
-- Terminal 分屏
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
------------------------------

--Visual
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)
-- 上下移动[选中]的文本
map('v', 'J', ":move '>+1<CR>gv-gv", opt)
map('v', 'K', ":move '<-2<CR>gv-gv", opt)

-- 快速移动
map('n', '<C-j>', '5j', opt)
map('n', '<C-k>', '5k', opt)
-- ctrl uppage, ctrl downpage, 默认半屏
-- map('n', '<C-u>', '9k', opt)
-- map('n', '<C-d>', '9j', opt)

-- 在visul模式里粘贴不要复制
map('v', 'p', '"_dP', opt)

-------------------------------
--nvim-tree
-------------------------------
local pluginKeys = {}
map('n', '<C-n>', ':NvimTreeToggle<CR>', opt)
pluginKeys.nvimTreeList = {
  -- 打开文件
  { key = {'<CR>', 'o', '<2-LeftMouse>'}, action = 'edit' },
  -- 分屏打开
  { key = 'v', action = 'vsplit' },
  { key = 'h', action = 'split' },
  -- 显示隐藏文件
  { key = 'i', action = 'toggle_ignored' },
  { key = '.', action = 'toggle_dotfiles' },
  -- 文件操作
  { key = '<F5>', action = 'refresh' },
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'r', action = 'rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  { key = 's', action = 'system_open' },
}

-------------------------------
--bufferline
-------------------------------
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)


return pluginKeys
