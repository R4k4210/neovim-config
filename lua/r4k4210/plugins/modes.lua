return {
  "mvllow/modes.nvim",
  tag = "v0.3.0",
  config = function()
    local c = require("r4k4210.core.colors")

    require("modes").setup({
      colors = {
        copy = c.accent.yellow,
        delete = c.accent.red,
        insert = c.accent.green,
        visual = c.accent.purple,
        replace = c.cursor.bg,
        format = c.accent.cyan,
        bg = "",
      },

      -- Set opacity for cursorline and number background
      line_opacity = 0.15,

      -- Enable cursor highlights (this changes cursor color based on mode)
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,

      -- Enable sign column highlights to match cursorline
      set_signcolumn = true,

      -- Disable modes highlights for specified filetypes
      ignore = {
        "NvimTree",
        "neo-tree",
        "TelescopePrompt",
        "toggleterm",
        "alpha",
        "dashboard",
        "snacks_dashboard",
        "lazy",
        "mason",
        "avante",
      },
    })
  end,
}
