local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("not found null-ls")
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting ---------------------
    -- StyLua
    -- formatting.stylua,
    formatting.clang_format,
    -- frontend
    -- formatting.fixjson,
    -- formatting.black.with({ extra_args = { "--fast" } }),
  },
})
