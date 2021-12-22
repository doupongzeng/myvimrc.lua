--- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local cmd = vim.cmd -- to execute vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call vim functions e.g. fn.buffer()
local g = vim.g   -- a table to access global variables
local opt = vim.opt -- to set options


require('packer').startup(function()
-- lua companion plugins
-- for completion
use {'hrsh7th/cmp-nvim-lsp'}
use {'hrsh7th/cmp-buffer'}
use {'hrsh7th/cmp-path'}
use {'hrsh7th/cmp-cmdline'}
use {'hrsh7th/nvim-cmp'}
-- for snippet
use {'hrsh7th/cmp-vsnip'}
use {'hrsh7th/vim-vsnip'}

use {'wbthomason/packer.nvim'}
use {'nvim-lua/plenary.nvim'}
use {'nvim-lua/popup.nvim'}
use {'svermeulen/vimpeccable'} --Map keys

-- plugins
use {'windwp/nvim-autopairs'}
use {'nvim-treesitter/nvim-treesitter'}
use {'folke/tokyonight.nvim'}
use {'hoob3rt/lualine.nvim'}
use {'neovim/nvim-lspconfig'}
use {'nvim-telescope/telescope.nvim'}
use {'kyazdani42/nvim-web-devicons'}
use {'tpope/vim-commentary'}
use {'kyazdani42/nvim-tree.lua'}
use {'romgrk/barbar.nvim'}
use {"numtostr/FTerm.nvim"}
use {"tpope/vim-surround"}
use {"vim-scripts/ReplaceWithRegister"}
use {"vim-scripts/argtextobj.vim"}
use {"tommcdo/vim-exchange"}
use {"yuezk/vim-js"}
use {"maxmellon/vim-jsx-pretty"}
end)



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
opt.mouse = 'nv'

-- colorscheme
vim.g.tokyonight_style = "night"
cmd 'colorscheme tokyonight'

-- map keys
g.mapleader = " " --<leader>
-- vimp is shorthand for vimpeccable
local vimp = require('vimp')

-- Use clipboard
vimp.nnoremap('ye', '"+ye')
vimp.nnoremap('yw', '"+yw')
vimp.nnoremap('yiw', '"+yiw')
vimp.nnoremap('yaw', '"+yaw')
vimp.nnoremap('yy', '"+yy')
vimp.vnoremap('y', '"+y')
vimp.nnoremap('p', '"+p')
vimp.vnoremap('p', '"+p')
vimp.nnoremap('P', '"+P')
vimp.vnoremap('P', '"+P')
vimp.nnoremap('dd', '"+dd')
vimp.vnoremap('d', '"+d')
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

require'nvim-tree'.setup()
vimp.nnoremap("<C-n>", [[:NvimTreeToggle<CR>]])

--barbar.nvim
vimp.nnoremap({'silent'}, '<leader>1', [[:BufferGoto 1<CR>]])
vimp.nnoremap({'silent'}, '<leader>2', [[:BufferGoto 2<CR>]])
vimp.nnoremap({'silent'}, '<leader>3', [[:BufferGoto 3<CR>]])
vimp.nnoremap({'silent'}, '<leader>4', [[:BufferGoto 4<CR>]])
vimp.nnoremap({'silent'}, '<leader>5', [[:BufferGoto 5<CR>]])
vimp.nnoremap({'silent'}, '<leader>6', [[:BufferGoto 6<CR>]])
vimp.nnoremap({'silent'}, '<leader>7', [[:BufferGoto 7<CR>]])
vimp.nnoremap({'silent'}, '<leader>8', [[:BufferGoto 8<CR>]])
vimp.nnoremap({'silent'}, '<leader>9', [[:BufferGoto 9<CR>]])
vimp.nnoremap({'silent'}, '<leader>0', [[:BufferLast<CR>]])

vimp.nnoremap({'silent'}, '<leader>tc', [[:BufferClose<CR>]])
vimp.nnoremap({'silent'}, '<leader>ta', [[:BufferCloseAllButCurrent<CR>]])

vimp.nnoremap({'silent'}, '<M-t>', [[:lua require("FTerm").toggle()<CR>]])
vimp.tnoremap({'silent'}, '<M-t>', '<C-\\><C-n><Cmd>lua require("FTerm").toggle()<CR>')

-- setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- telescope
local ts = require 'nvim-treesitter.configs'
ts.setup{
    ensure_installed = 'maintained',
    highlight = {enable = true}
}

local tsin = require('telescope.builtin')
vimp.nnoremap('<leader>ff', [[:Telescope find_files<CR>]])
vimp.nnoremap('<leader>fg', [[:Telescope live_grep<CR>]])
vimp.nnoremap('<leader>fb', [[:Telescope buffers<CR>]])
-- find in help page
vimp.nnoremap('<leader>fh', [[:Telescope help_tags<CR>]])


-- nvim-autopairs
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
})

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
local nvim_lsp_configs = require 'lspconfig.configs'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --[[
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  ]]

  vimp.nnoremap({'silent'}, 'gd', [[:lua vim.lsp.buf.definition()<CR>]])
  vimp.nnoremap({'silent'}, 'gD', [[:lua vim.lsp.buf.declaration()<CR>]])
  vimp.nnoremap({'silent'}, 'gh', [[:lua vim.lsp.buf.hover()<CR>]])
  vimp.nnoremap({'silent'}, 'gk', [[:lua vim.lsp.buf.signature_help()<CR>]])
  vimp.nnoremap({'silent'}, '<F2>', [[:lua vim.lsp.buf.document_symbol()<CR>]])
  vimp.nnoremap({'silent'}, 'gu', [[:lua vim.lsp.buf.references()<CR>]])
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --https://github.com/vshaxe/vshaxe/wiki/Code-Actions
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vimp.nnoremap({'silent'}, '<leader>ca', [[:lua vim.lsp.buf.code_action()<CR>]])
  --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --[[
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  ]]
  vimp.nnoremap({'silent'}, '[e', [[:lua vim.lsp.diagnostic.goto_prev()<CR>]])
  vimp.nnoremap({'silent'}, ']e', [[:lua vim.lsp.diagnostic.goto_next()<CR>]])
  vimp.nnoremap({'silent'}, '<leader>e', [[:lua vim.lsp.diagnostic.set_loclist()<CR>]])
  vimp.nnoremap({'silent'}, '<leader>fo', [[:lua vim.lsp.buf.formatting()<CR>]])

  --nnoremap <silent> <F4> :<C-u>CocCommand clangd.switchSourceHeader<CR>
  -- vimp.nnoremap({'silent'}, '<F4>', [[:ClangdSwitchSourceHeader<CR>]])
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ccls', 'jsonls', 'bashls', 'cmake', 'tsserver', 'ls_emmet' }
for _, lsp in ipairs(servers) do
    if(lsp == 'ls_emmet') then
       local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        if not nvim_lsp_configs.ls_emmet then
            nvim_lsp_configs.ls_emmet = {
                default_config = {
                    cmd = { 'ls_emmet', '--stdio' };
                    filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml',
                    'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss'};
                    root_dir = function(fname)
                        return vim.loop.cwd()
                    end;
                    settings = {};
                };
            }
        end
        nvim_lsp.ls_emmet.setup({
            capabilities = capabilities
        })
    else
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end
end

-- terminal
require'FTerm'.setup({
    dimensions  = {
        height = 0.5,
        width = 0.5,
        x = 0.5,
        y = 0.5
    },
    border = 'single' -- or 'double'
})

