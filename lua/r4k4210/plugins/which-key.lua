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

    wk.add({
      {
        "<leader>b",
        group = "Buffers",
        expand = function()
          return require("which-key.extras").expand.buf()
        end
      },
      { "<leader>c", desc = "Code Actions" },
      { "<leader>f", desc = "Telescope" },
      { "<leader>g", desc = "Git" },
      { "<leader>m", desc = "LazyDocker and format" },
      { "<leader>n", hidden = true },
      { "<leader>p", hidden = true },
      { "<leader>r", desc = "LSP" },
      { "<leader>s", desc = "Widows Split" },
      { "<leader>t", desc = "Tabs" },
      { "<leader>u", desc = "UI" },
      { "<leader>z", desc = "Color Picker" }
    })
  end,
}
