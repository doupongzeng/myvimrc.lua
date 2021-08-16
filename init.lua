local cmd = vim.cmd -- to execute vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call vim functions e.g. fn.buffer()
local g = vim.g   -- a table to access global variables
local opt = vim.opt -- to set options


require('packer').startup(function()
-- lua companion plugins
use {'wbthomason/packer.nvim'}
use {'nvim-lua/plenary.nvim'}
use {'nvim-lua/popup.nvim'}
use {'svermeulen/vimpeccable'} --Map keys

-- plugins
use {'hrsh7th/nvim-compe'}
use {'windwp/nvim-autopairs'}
use {'nvim-treesitter/nvim-treesitter'}
use {'folke/tokyonight.nvim'}
use {'hoob3rt/lualine.nvim'}
use {'neovim/nvim-lspconfig'}
use {'nvim-telescope/telescope.nvim'}
use {'kyazdani42/nvim-web-devicons'}
use {'winston0410/commented.nvim'}
use {'kyazdani42/nvim-tree.lua'}
use {'romgrk/barbar.nvim'}
end)



-- colorscheme
vim.g.tokyonight_style = "night"
cmd 'colorscheme tokyonight'

opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.smartcase = true                -- Do not ignore case with capitals
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.listchars = 'tab:> ,extends:>,precedes:<,nbsp:.,trail:•'
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

-- Use clipboard
vimp.nnoremap('<leader>y', '"+y')
vimp.nnoremap('<leader>p', '"+p') -- after line
-- vimp.nnoremap('<leader>P', '"+P') -- before line

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

-- Arguments: mode (optional)
-- :ShowAllMaps i
vimp.map_command("ShowAllMaps", function(...) 
  -- Use empty string as prefix to select all
  vimp.show_maps('', ...)
end)

-- Arguments: prefix (required), mode (optional)
-- :ShowMaps <space> n
vimp.map_command("ShowMaps", function(...) 
  vimp.show_maps(...)
end)

vimp.nnoremap("<C-n>", function() 
    cmd(":NvimTreeToggle")
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
require('nvim-autopairs').setup()
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

--LSP
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --https://github.com/vshaxe/vshaxe/wiki/Code-Actions
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --nnoremap <silent> <F4> :<C-u>CocCommand clangd.switchSourceHeader<CR>
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ccls', 'jsonls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- comment toggle
require('commented').setup {
	comment_padding = " ", -- padding between starting and ending comment symbols
	keybindings = {n = "<leader>c", v = "<leader>c", nl = "<leader>cc"}, -- what key to toggle comment, nl is for mapping <leader>c$, just like dd for d
	prefer_block_comment = false, -- Set it to true to automatically use block comment when multiple lines are selected
	set_keybindings = true, -- whether or not keybinding is set on setup
	ex_mode_cmd = "Comment" -- command for commenting in ex-mode, set it null to not set the command initially.
}

