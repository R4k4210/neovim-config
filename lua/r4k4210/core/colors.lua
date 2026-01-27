-- Centralized color palette for all plugins
-- Change colors here and they'll update everywhere

local M = {}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                              Base Colors                                  ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.base = {
  bg = "#0d1117", -- main background (darker)
  bg_dark = "#080b0f", -- darkest (for contrast elements)
  bg_light = "#151b23", -- lighter bg (for highlights, selections)
  bg_lighter = "#1c242e", -- even lighter (for UI elements)
  bg_lightest = "#242d39", -- lightest bg (for hover states)
  fg = "#93a4c3", -- main foreground
  fg_dark = "#6c7d9c", -- dimmed foreground (comments)
  fg_light = "#b4c5e4", -- bright foreground (emphasis)
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                             Accent Colors                                 ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.accent = {
  red = "#f65866",
  green = "#8bcd5b",
  yellow = "#efbd5d",
  blue = "#41a7fc",
  purple = "#c75ae8",
  cyan = "#34bfd0",
  orange = "#dd9046",
  pink = "#e06c9a",
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                              Diff Colors                                  ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.diff = {
  add = "#1a2e1a",
  delete = "#2e1a1a",
  change = "#1a2040",
  text = "#1a3050",
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                            Diagnostic Colors                              ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.diagnostic = {
  error = "#f65866",
  warn = "#efbd5d",
  info = "#41a7fc",
  hint = "#34bfd0",
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                              Cursor Colors                                ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.cursor = {
  bg = "#ff4000", -- cursor background (orange/red)
  fg = "#0d1117", -- cursor foreground (matches main bg)
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                           Lualine Colors                                  ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.lualine = {
  bg = M.base.bg,
  fg = M.base.fg,
  yellow = M.accent.yellow,
  cyan = M.accent.cyan,
  darkblue = "#102b40",
  green = M.accent.green,
  orange = M.accent.orange,
  violet = M.accent.purple,
  magenta = M.accent.purple,
  blue = M.accent.blue,
  red = M.accent.red,
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                        Render Markdown Colors                             ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.markdown = {
  h1_bg = M.base.bg_lightest,
  h2_bg = M.base.bg_lighter,
  h3_bg = M.base.bg_light,
  h4_bg = "#121920",
  h5_bg = M.base.bg,
  h6_bg = "#0a0e13",
  code_bg = M.base.bg_dark,
  code_inline_bg = M.base.bg_light,
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                            Avante Colors                                  ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.avante = {
  -- Sidebar & Input
  sidebar_bg = M.base.bg,
  sidebar_fg = M.base.fg,
  prompt_bg = M.base.bg,
  prompt_fg = M.base.fg,
  prompt_border = M.base.fg_dark,
  popup_bg = M.base.bg_light,
  inline_hint = M.accent.purple,

  -- Titles
  title_fg = M.base.bg,
  title_bg = M.accent.green,
  subtitle_fg = M.base.bg,
  subtitle_bg = M.accent.cyan,
  third_title_fg = M.base.fg,
  third_title_bg = M.base.bg_lightest,
  confirm_title_bg = M.accent.red,

  -- Buttons
  button_default_bg = M.base.fg_dark,
  button_hover_bg = M.accent.green,
  button_primary_bg = M.accent.blue,
  button_primary_hover_bg = M.accent.cyan,
  button_danger_hover_bg = M.accent.red,

  -- Spinners
  spinner_generating = M.accent.purple,
  spinner_tool_calling = M.accent.cyan,
  spinner_succeeded = M.accent.green,
  spinner_failed = M.accent.red,

  -- Task status
  task_running = M.accent.purple,
  task_completed = M.accent.green,
  task_failed = M.accent.red,

  -- Misc
  suggestion = M.base.fg_dark,
  annotation = M.base.fg_dark,
  separator = M.base.fg_dark,
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                          Smear Cursor Colors                              ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.smear = {
  cursor = "#ff4000", -- matches cursor.bg
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                              NeoTree                                      ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.neotree = {
  bg = M.base.bg,
  fg = M.base.fg,
  cursor_line = M.base.bg_lighter,
  directory_icon = M.accent.blue,
  root_name = M.accent.blue,
  indent_marker = M.base.fg_dark,
  git_added = M.accent.green,
  git_modified = M.accent.yellow,
  git_deleted = M.accent.red,
  git_untracked = M.accent.orange,
}

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                        Snacks Picker/Explorer                             ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
M.snacks = {
  normal_bg = M.base.bg,
  normal_fg = M.base.fg,
  border = M.base.fg_dark,
  title_bg = M.accent.blue,
  title_fg = M.base.bg,
  input_bg = M.base.bg_light,
  input_fg = M.base.fg,
  list_bg = M.base.bg,
  preview_bg = M.base.bg,
  selection_bg = M.base.bg_lighter,
  match_fg = M.accent.yellow,
  dir_fg = M.accent.blue,
  file_fg = M.base.fg,
}

return M
