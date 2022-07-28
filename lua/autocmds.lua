local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 用o换行不要延续注释
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
  end,
})

-- nvim-tree 自动关闭
autocmd("BufEnter", {
  nested = true,
  group = myAutoGroup,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})

-- 进入Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = myAutoGroup,
  command = "startinsert",
})

-- 保存时自动格式化
--[[ autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = { "*.lua", "*.py", "*.sh", "*.cpp", "*.h", "*.hpp", "*.json", "*.c" },
  callback = vim.lsp.buf.formatting,
}) ]]

autocmd("FileType", {
  group = myAutoGroup,
  pattern = { "cpp", "h", "c", "hpp" },
  callback = function()
    vim.o.tabstop = 4
    vim.bo.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.bo.shiftwidth = 4
  end
})

autocmd("FileType", {
  group = myAutoGroup,
  pattern = { "python", "json", "yaml", "javascript", "typescript", "rust", "go", "cmake", "lua" },
  callback = function()
    vim.o.tabstop = 2
    vim.bo.tabstop = 2
    vim.o.softtabstop = 2
    vim.o.shiftwidth = 2
    vim.bo.shiftwidth = 2
  end
})

-- 修改lua/plugins.lua 自动更新插件
autocmd("BufWritePost", {
  group = myAutoGroup,
  -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
  callback = function()
    if vim.fn.expand("<afile>") == "lua/plugins.lua" then
      vim.api.nvim_command("source lua/plugins.lua")
      vim.api.nvim_command("PackerSync")
    end
  end,
})

autocmd("InsertLeave", {
  group = myAutoGroup,
  callback = require("utils.im-select").linuxInsertLeave,
})
autocmd("InsertEnter", {
  group = myAutoGroup,
  callback = require("utils.im-select").linuxInsertEnter,
})

-- Highlight on yank
--[[ autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = myAutoGroup,
  pattern = "*",
}) ]]
