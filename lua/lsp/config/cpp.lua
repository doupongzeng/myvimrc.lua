local opts = {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
