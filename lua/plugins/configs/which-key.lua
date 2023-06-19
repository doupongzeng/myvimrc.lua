return function(_, opts)
  require("which-key").setup(opts)
  require("yellow.utils").which_key_register()
end
