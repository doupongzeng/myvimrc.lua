local opts = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, _)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end,
}
return {
  on_setup = function (server)
    server.setup{
      on_attach = opts.on_attach,
      flags = opts.flags,
      capabilities = opts.capabilities,
      settings = opts.settings,
    }
  end

}
