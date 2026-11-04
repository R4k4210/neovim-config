return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      -- crew.nvim draws its own workspace pills in place of the tab numbers.
      -- Remove custom_areas to show them only in lualine.
      show_tab_indicators = false,
      -- Inside agent tabs, hide editor buffers and show the agent header instead
      custom_filter = function(buf)
        return require("crew.bufferline").filter(buf)
      end,
      custom_areas = {
        left = function()
          return require("crew.bufferline").left()
        end,
        right = function()
          return require("crew.bufferline").right()
        end,
      },
    },
  },
  config = function(_, opts)
    local bufferline = require("bufferline")
    -- local mocha = require("catppuccin.palettes").get_palette("mocha")

    bufferline.setup(opts
      --   {
      --   highlights = require("catppuccin.groups.integrations.bufferline").get({
      --     styles = { "italic", "bold" },
      --     custom = {
      --       all = {
      --         fill = { bg = "#000000" },
      --       },
      --       mocha = {
      --         background = { fg = mocha.text },
      --       },
      --       latte = {
      --         background = { fg = "#000000" },
      --       },
      --     },
      --   }),
      -- }
    )
  end,
}
