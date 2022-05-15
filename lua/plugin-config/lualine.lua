local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("not found lualine")
  return
end

lualine.setup({
  options = {
    theme = "tokyonight",
    -- 分段中的组件分隔符
    component_separators = { left = "|", right = "|" },
    -- 分段分隔符
    -- https://github.com/ryanoasis/powerline-extra-symbols
    -- section_separators = { left = " ", right = "" },
  },
  extensions = { "nvim-tree", "toggleterm" },
  --+-------------------------------------------------+
  --| A | B | C                             X | Y | Z |
  --+-------------------------------------------------+
  --不同的分段
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },
    lualine_x = {
      "filesize",
      {
        "fileformat",
        -- symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "encoding",
      "filetype",
    },
  },
})
