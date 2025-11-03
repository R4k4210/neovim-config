return {
  ---@type "right" | "left" | "top" | "bottom"
  position = "left", -- Sidebar position
  wrap = true, -- Similar to vim.o.wrap
  width = 40, -- More space for side-by-side viewing
  sidebar_header = {
    enabled = true, -- Enables/disables sidebar header
    align = "center", -- Title alignment: left, center, or right
    rounded = true,
  },
  input = {
    prefix = "> ",
    height = 8, -- Input window height in vertical layout
    border = "solid", -- Solid border for better visual separation
  },
  edit = {
    border = "solid", -- Solid border for better visual separation
    start_insert = true, -- Start in insert mode when opening edit window
  },
  ask = {
    floating = false, -- Opens 'AvanteAsk' prompt in a floating window
    start_insert = true, -- Start in insert mode when opening ask window
    border = "solid", -- Solid border for better visual separation
    ---@type "ours" | "theirs"
    focus_on_apply = "ours", -- Which diff to focus on after applying
  },
}
