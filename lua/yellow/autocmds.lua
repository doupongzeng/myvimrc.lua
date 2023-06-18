local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
local namespace = vim.api.nvim_create_namespace

local utils = require "yellow.utils"
local is_available = utils.is_available

if is_available "alpha-nvim" then
  autocmd({ "User", "BufEnter" }, {
    desc = "Disable status and tablines for alpha",
    group = augroup("alpha_settings", { clear = true }),
    callback = function(event)
      if
        (
          (event.event == "User" and event.file == "AlphaReady")
          or (event.event == "BufEnter" and vim.api.nvim_get_option_value("filetype", { buf = event.buf }) == "alpha")
        ) and not vim.g.before_alpha
      then
        vim.g.before_alpha = { showtabline = vim.opt.showtabline:get(), laststatus = vim.opt.laststatus:get() }
        vim.opt.showtabline, vim.opt.laststatus = 0, 0
      elseif
        vim.g.before_alpha
        and event.event == "BufEnter"
        and vim.api.nvim_get_option_value("buftype", { buf = event.buf }) ~= "nofile"
      then
        vim.opt.laststatus, vim.opt.showtabline = vim.g.before_alpha.laststatus, vim.g.before_alpha.showtabline
        vim.g.before_alpha = nil
      end
    end,
  })
  autocmd("VimEnter", {
    desc = "Start Alpha when vim is opened with no arguments",
    group = augroup("alpha_autostart", { clear = true }),
    callback = function()
      local should_skip = false
      if vim.fn.argc() > 0 or vim.fn.line2byte(vim.fn.line "$") ~= -1 or not vim.o.modifiable then
        should_skip = true
      else
        for _, arg in pairs(vim.v.argv) do
          if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            should_skip = true
            break
          end
        end
      end
      if not should_skip then require("alpha").start(true, require("alpha").default_config) end
    end,
  })
end

