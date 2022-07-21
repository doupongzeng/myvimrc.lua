local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("not found nvim-treesitter")
  return
end

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "cpp", "bash", "cuda", "python" },
  -- 启用代码高亮模块
  highlight = {
    -- 开启高亮
    enable = true,
    -- 关闭vim的正则高亮
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = require('keybindings').textobj,
    }
  }
})

-- 开启 Folding 代码折叠模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
