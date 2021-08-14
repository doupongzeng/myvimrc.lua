-- in tools.lua
local api = vim.api
local M = {}
function M.makeScratch()
--    api.nvim_command('enew') -- :enew
--    vim.bo[1].buftype=nofile  -- set the current buffer's (buffer 0) buftype to nofile
--    vim.bo[1].bufhidden = hide
--    vim.bo[1].swapfile = false
    print('hellow ')
end
return M
