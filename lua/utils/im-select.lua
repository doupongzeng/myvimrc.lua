local M = {}

M.defaultIM = 1
M.currentIM = M.defaultIM

M.linuxInsertLeave = function()
  M.currentIM = tonumber(vim.fn.system({ "fcitx-remote" }))
  vim.cmd(":silent :!fcitx-remote -c")
end

M.linuxInsertEnter = function()
  if M.currentIM == 2 then
    vim.cmd(":silent :!fcitx-remote -o")
  end
end

M.macInsertLeave = function()
  M.currentIM = vim.fn.system({ "im-select" })
  vim.cmd(":silent :!im-select" .. " " .. M.defaultIM)
end

M.macInsertEnter = function()
  if M.currentIM then
    vim.cmd(":silent :!im-select" .. " " .. M.currentIM)
  else
    vim.cmd(":silent :!im-select" .. " " .. M.defaultIM)
  end
end

M.windowsInsertLeave = function()
  vim.cmd(":silent :!~/.config/nvim/im-select.exe 1033")
end

M.windowsInsertEnter = function()
  vim.cmd(":silent :!~/.config/nvim/im-select.exe 2052")
end
return M
