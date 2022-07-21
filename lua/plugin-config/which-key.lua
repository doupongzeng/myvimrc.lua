local status, whichkey = pcall(require, "which-key")
if not status then
  vim.notify("not found telescope")
  return
end

whichkey.setup({})
