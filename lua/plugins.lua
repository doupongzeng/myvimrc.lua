local packer = require('packer')
packer.startup({
  function(use)
    -- :h base-directories
    -- ~/.local/share/nvim/
    -- :echo stdpath('data')
    use('wbthomason/packer.nvim')
    use('folke/tokyonight.nvim')
  end,
  config = {
    max_jobs = 16,
    -- 源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    }
  }
})



-- :colorscheme Tab键
-- :echo $VIMRUNTIME

-- 每次保存plugins.lua 自动安装插件
-- pcall lua函数,检查一个函数是否执行成功
pcall(
  vim.cmd,
  -- vim脚本
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
