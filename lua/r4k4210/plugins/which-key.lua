return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        presets = {
          operators = false,
        },
      },
    })

    wk.register({
      b = "Buffers",
      c = "Code Actions",
      f = "Telescope",
      g = "Git",
      m = "LazyDocker and format",
      n = "which_key_ignore",
      p = "which_key_ignore",
      r = "LSP",
      s = "Widows Split",
      t = "Tabs",
      u = "UI",
      z = "Color Picker",
    }, { prefix = "<leader>" })
  end,
}
