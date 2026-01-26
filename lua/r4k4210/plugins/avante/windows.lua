return {
  ---@type "right" | "left" | "top" | "bottom" | "smart"
  position = "left", -- Sidebar position
  wrap = true, -- Similar to vim.o.wrap
  width = 40, -- Percentage of screen width
  fillchars = "eob: ", -- Hide ~ on empty lines
  sidebar_header = {
    enabled = true, -- Enables/disables sidebar header
    align = "center", -- Title alignment: left, center, or right
    rounded = true,
  },
  input = {
    prefix = "> ",
    height = 8, -- Input window height in vertical layout
    border = "rounded", -- Rounded border looks cleaner
  },
  edit = {
    border = "rounded", -- Rounded border looks cleaner
    start_insert = true, -- Start in insert mode when opening edit window
  },
  ask = {
    floating = false, -- Opens 'AvanteAsk' prompt in a floating window
    start_insert = true, -- Start in insert mode when opening ask window
    border = "rounded", -- Rounded border looks cleaner
    ---@type "ours" | "theirs"
    focus_on_apply = "theirs", -- Focus on the new changes to review them
  },
}
