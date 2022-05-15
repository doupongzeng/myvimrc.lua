local packer = require('packer')
packer.startup({
  function(use)
    -- :h base-directories
    -- ~/.local/share/nvim/
    -- :echo stdpath('data')
    use('wbthomason/packer.nvim')
    use('folke/tokyonight.nvim')
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")

    use({ 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } })
    use("ahmedkhalf/project.nvim")

    use("glepnir/dashboard-nvim")

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    use({ "williamboman/nvim-lsp-installer", commit = "36b44679f7cc73968dbb3b09246798a19f7c14e0" })
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
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
