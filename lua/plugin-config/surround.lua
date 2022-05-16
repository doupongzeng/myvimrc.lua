local status, surround = pcall(require, "surround")
if not status then
  vim.notify("not found surround")
  return
end

surround.setup({
  mappings_style = "surround",
})
