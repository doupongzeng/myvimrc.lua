local cmd = vim.cmd -- to execute vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call vim functions e.g. fn.buffer()
local g = vim.g   -- a table to access global variables
local opt = vim.opt -- to set options


cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt=true}

-- lua companion plugins
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-lua/popup.nvim'}
paq {'svermeulen/vimpeccable'} --Map keys

-- plugins
paq {'hrsh7th/nvim-compe'}
paq {'windwp/nvim-autopairs'}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'folke/tokyonight.nvim'}
paq {'hoob3rt/lualine.nvim'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-telescope/telescope.nvim'}
paq {'kyazdani42/nvim-web-devicons'}


-- colorscheme
vim.g.tokyonight_style = "night"
cmd 'colorscheme tokyonight'

opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.smartcase = true                -- Do not ignore case with capitals
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 7                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 4                  -- Size of an indent
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.sidescrolloff = 8               -- Columns of context
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.termguicolors = true            -- True color support
opt.wrap = false                    -- Disable line wrap

-- map keys
g.mapleader = " " --<leader>
-- vimp is shorthand for vimpeccable
local vimp = require('vimp')

-- r = reload vimrc
vimp.nnoremap('<leader>r', function()
  -- Remove all previously added vimpeccable maps
  vimp.unmap_all()
  -- Unload the lua namespace so that the next time require('config.X') is called
  -- it will reload the file
  require("config.util").unload_lua_namespace('config')
  -- Make sure all open buffers are saved
  vim.cmd('silent wa')
  -- Execute our vimrc lua file again to add back our maps
  dofile(vim.fn.stdpath('config') .. '/init.lua')

  print("Reloaded vimrc!")
end)

-- telescope
local ts = require 'nvim-treesitter.configs'
ts.setup{
    ensure_installed = 'maintained', 
    highlight = {enable = true}
}

local tsin = require('telescope.builtin')
vimp.nnoremap('<leader>ff', function()
    tsin.find_files()
end)
vimp.nnoremap('<leader>fg', function() 
    tsin.live_grep()
end)
vimp.nnoremap('<leader>fb', function() 
    tsin.buffers()
end)
-- find in help page
vimp.nnoremap('<leader>fh', function() 
    tsin.help_tags()
end)



-- nvim-autopairs
require('nvim-autopairs').setup{}
require('nvim-autopairs.completion.compe').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
})

-- nvim-compe
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

-- lualine
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
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
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

