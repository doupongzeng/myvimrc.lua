local colorscheme = 'tokyonight'
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- 在状态栏显示提醒
  vim.notify('colorscheme ' .. colorscheme .. " not found!")
  return
end

