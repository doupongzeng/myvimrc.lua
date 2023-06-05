-- [[
-- vim.g.{name} 全局变量
-- vim.b.{name} 缓冲区变量
-- vim.w.{name} 窗口变量
-- vim.bo.{option} buffer-local 选项
-- vim.wo.{option} window-local 选项
-- ]]

vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'utf-8'

-- jkhl scroll offset
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.wo.number = true
vim.wo.relativenumber = true

-- heightlight current row
-- vim.wo.cursorline = true

-- 显示行号左侧的指示列
vim.wo.signcolumn = 'yes'

-- 缩进2个空格等于一个tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- space alternative tab
vim.o.expandtab = true
vim.bo.expandtab = true

-- >> << 移动时长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 搜索忽略大小写，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 搜索高亮
-- vim.o.hlsearch = false
-- 边输入边搜索
-- vim.o.incsearch = false

-- 命令行行高2
vim.o.cmdheight = 2

-- 当文件被外部修改时自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 禁止折行
vim.wo.wrap = false

-- 光标在行首尾时 <- -> 键可以跳到下一行
-- vim.o.whichwrap = '<,>,[,]'

-- 允许隐藏被修改过的buffer
vim.o.hidden = true

-- 允许鼠标支持
vim.o.mouse = 'a'

-- 禁止创建备份文件
vim.o.backup = false
vim.writebackup = false
vim.o.swapfile = false

-- smaller updatetime
vim.o.updatetime = 300
-- 连续按键时间间隔
vim.o.timeoutlen = 500

-- split windows 从右边或下面出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 样式
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- 不可见字符显示，把空格用点显示
vim.o.list = true
vim.o.listchars = 'tab:..,trail:·,extends:>,precedes:<,nbsp:~'

-- 使用增强状态栏后不在需要vim的模式提示
vim.o.showmode = false

-- 自动补全不自动选中
vim.g.completeopt = 'menu,menuone,noselect,noinsert'
-- 补全增强
vim.o.wildmenu = true
-- Don't pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
-- 补全最多显示10行
vim.o.pumheight = 10
-- 永远显示tabline
vim.o.showtabline = 2

