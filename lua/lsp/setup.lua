local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup{}
local lspconfig = require('lspconfig')

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  bashls = require('lsp.config.bash'),
  cmake = require('lsp.config.cmake'),
  pyright = require('lsp.config.python'),
  jsonls = require('lsp.config.json'),
  ccls = require('lsp.config.cpp'),
}

-- 自动安装 Language Servers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. server.name)
      server:install()
    end
  end
end

for name, _ in pairs(servers) do
  local config = servers[name]
  if config == nil then
    print(name .. "has no config file")
  else
    lspconfig[name].setup{config.opts}
  end
end



