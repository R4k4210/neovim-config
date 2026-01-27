return {
  "mvllow/modes.nvim",
  tag = "v0.3.0",
  config = function()
    require("modes").setup({
      colors = {
        -- Using OneDark Deep palette colors + smear cursor color
        copy = "#efbd5d", -- yellow - for yank operations
        delete = "#f65866", -- red - for delete operations
        insert = "#8bcd5b", -- green - for insert mode
        visual = "#c75ae8", -- purple - for visual mode
        replace = "#ff4000", -- orange/red - matches smear cursor
        format = "#34bfd0", -- cyan - for format operations
        -- Optional: set background color (defaults to Normal hl group if not set)
        bg = "", -- Leave empty to use default
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
      ignore_filetypes = {
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
