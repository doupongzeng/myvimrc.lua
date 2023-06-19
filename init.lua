for _, source in ipairs {
  "yellow.options",
  "yellow.lazy",
  "yellow.autocmds",
  "yellow.mappings",
}
do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load" .. source .. "\n\n" .. fault) end
end
