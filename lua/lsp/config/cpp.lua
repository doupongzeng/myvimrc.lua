local opts = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  -- 会和null-ls冲突，null-ls默认为"utf-16" https://github.com/neovim/neovim/blob/ff1b0f632a8d3aed0ba861057e7bd8ade4540277/runtime/lua/vim/lsp/util.lua#L1771
  capabilities.offsetEncoding = { "utf-16" },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
  end,
}

-- 查看目录等信息
return {
  on_setup = function (server)
    server.setup{
      on_attach = opts.on_attach,
      flags = opts.flags,
      capabilities = opts.capabilities,
    }
  end
}
