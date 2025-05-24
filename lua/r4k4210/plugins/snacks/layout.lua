local function get_layout(style)
  local layouts = {
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                      VSCODE LAYOUT                         │
    -- ╰────────────────────────────────────────────────────────────╯
    vscode = {
      preview = false,
      layout = {
        backdrop = false,
        row = 1,
        width = 0.4,
        min_width = 80,
        height = 0.4,
        border = "none",
        box = "vertical",
        { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
        { win = "list", border = "hpad" },
        { win = "preview", title = "{preview}", border = "rounded" },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                      VERTICAL LAYOUT                       │
    -- ╰────────────────────────────────────────────────────────────╯
    vertical = {
      layout = {
        backdrop = false,
        width = 0.5,
        min_width = 80,
        height = 0.8,
        min_height = 30,
        box = "vertical",
        border = "rounded",
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                     TELESCOPE LAYOUT                       │
    -- ╰────────────────────────────────────────────────────────────╯
    telescope = {
      reverse = true,
      layout = {
        box = "horizontal",
        backdrop = false,
        width = 0.8,
        height = 0.9,
        border = "none",
        {
          box = "vertical",
          { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
          { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
        },
        {
          win = "preview",
          title = "{preview:Preview}",
          width = 0.45,
          border = "rounded",
          title_pos = "center",
        },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                      SIDEBAR LAYOUT                        │
    -- ╰────────────────────────────────────────────────────────────╯
    sidebar = {
      preview = "main",
      layout = {
        backdrop = false,
        width = 40,
        min_width = 40,
        height = 0,
        position = "left",
        border = "none",
        box = "vertical",
        {
          win = "input",
          height = 1,
          border = "rounded",
          title = "{title} {live} {flags}",
          title_pos = "center",
        },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                      SELECT LAYOUT                         │
    -- ╰────────────────────────────────────────────────────────────╯
    select = {
      preview = false,
      layout = {
        backdrop = false,
        width = 0.5,
        min_width = 80,
        height = 0.4,
        min_height = 3,
        box = "vertical",
        border = "rounded",
        title = "{title}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                       IVY LAYOUT                           │
    -- ╰────────────────────────────────────────────────────────────╯
    ivy = {
      layout = {
        box = "vertical",
        backdrop = false,
        row = -1,
        width = 0,
        height = 0.4,
        border = "top",
        title = " {title} {live} {flags}",
        title_pos = "left",
        { win = "input", height = 1, border = "bottom" },
        {
          box = "horizontal",
          { win = "list", border = "none" },
          { win = "preview", title = "{preview}", width = 0.6, border = "left" },
        },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                    IVY_SPLIT LAYOUT                        │
    -- ╰────────────────────────────────────────────────────────────╯
    ivy_split = {
      preview = "main",
      layout = {
        box = "vertical",
        backdrop = false,
        width = 0,
        height = 0.4,
        position = "bottom",
        border = "top",
        title = " {title} {live} {flags}",
        title_pos = "left",
        { win = "input", height = 1, border = "bottom" },
        {
          box = "horizontal",
          { win = "list", border = "none" },
          { win = "preview", title = "{preview}", width = 0.6, border = "left" },
        },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                     DROPDOWN LAYOUT                        │
    -- ╰────────────────────────────────────────────────────────────╯
    dropdown = {
      layout = {
        backdrop = false,
        row = 1,
        width = 0.4,
        min_width = 80,
        height = 0.8,
        border = "none",
        box = "vertical",
        { win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
        {
          box = "vertical",
          border = "rounded",
          title = "{title} {live} {flags}",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
      },
    },
    -- ╭────────────────────────────────────────────────────────────╮
    -- │                      DEFAULT LAYOUT                        │
    -- ╰────────────────────────────────────────────────────────────╯
    default = {
      layout = {
        backdrop = false,
        width = 0.5,
        min_width = 80,
        height = 0.8,
        min_height = 30,
        box = "vertical",
        border = "rounded",
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
  }

  return layouts[style] or layouts["default"]
end

return get_layout
