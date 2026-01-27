return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local c = require("r4k4210.core.colors")

      require("onedark").setup({
        style = "deep",
        colors = {
          bg0 = c.base.bg,
        },
        highlights = {
          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                       Float/Popup Windows                         │
          -- └──────────────────────────────────────────────────────────────────┘
          NormalFloat = { bg = c.base.bg, fg = c.base.fg },
          FloatBorder = { bg = c.base.bg, fg = c.base.fg_dark },
          FloatTitle = { bg = c.accent.blue, fg = c.base.bg, bold = true },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                           NeoTree                                 │
          -- └──────────────────────────────────────────────────────────────────┘
          NeoTreeNormal = { bg = c.neotree.bg, fg = c.neotree.fg },
          NeoTreeNormalNC = { bg = c.neotree.bg, fg = c.neotree.fg },
          NeoTreeSignColumn = { bg = c.neotree.bg },
          NeoTreeEndOfBuffer = { bg = c.neotree.bg, fg = c.neotree.bg },
          NeoTreeWinSeparator = { bg = c.neotree.bg, fg = c.neotree.bg },
          NeoTreeVertSplit = { bg = c.neotree.bg, fg = c.neotree.bg },
          NeoTreeCursorLine = { bg = c.neotree.cursor_line },
          NeoTreeDirectoryName = { fg = c.neotree.fg },
          NeoTreeDirectoryIcon = { fg = c.neotree.directory_icon },
          NeoTreeRootName = { fg = c.neotree.root_name, bold = true },
          NeoTreeFileName = { fg = c.neotree.fg },
          NeoTreeFileIcon = { fg = c.neotree.fg },
          NeoTreeGitAdded = { fg = c.neotree.git_added },
          NeoTreeGitModified = { fg = c.neotree.git_modified },
          NeoTreeGitDeleted = { fg = c.neotree.git_deleted },
          NeoTreeGitUntracked = { fg = c.neotree.git_untracked },
          NeoTreeIndentMarker = { fg = c.neotree.indent_marker },
          NeoTreeFloatBorder = { bg = c.neotree.bg, fg = c.neotree.indent_marker },
          NeoTreeFloatTitle = { bg = c.neotree.directory_icon, fg = c.neotree.bg, bold = true },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                         Cursor Colors                            │
          -- └──────────────────────────────────────────────────────────────────┘
          Cursor = { bg = c.cursor.bg, fg = c.cursor.fg },
          lCursor = { bg = c.cursor.bg, fg = c.cursor.fg },
          TermCursor = { bg = c.cursor.bg, fg = c.cursor.fg },
          CursorLine = { bg = c.base.bg_light },
          CursorLineNr = { fg = c.accent.yellow, bold = true },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      render-markdown highlights                   │
          -- └──────────────────────────────────────────────────────────────────┘
          RenderMarkdownH1Bg = { bg = c.markdown.h1_bg },
          RenderMarkdownH2Bg = { bg = c.markdown.h2_bg },
          RenderMarkdownH3Bg = { bg = c.markdown.h3_bg },
          RenderMarkdownH4Bg = { bg = c.markdown.h4_bg },
          RenderMarkdownH5Bg = { bg = c.markdown.h5_bg },
          RenderMarkdownH6Bg = { bg = c.markdown.h6_bg },
          RenderMarkdownCode = { bg = c.markdown.code_bg },
          RenderMarkdownCodeInline = { bg = c.markdown.code_inline_bg },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      Avante Sidebar & Input                       │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteSidebarNormal = { bg = c.avante.sidebar_bg, fg = c.avante.sidebar_fg },
          AvantePromptInput = { bg = c.avante.prompt_bg, fg = c.avante.prompt_fg },
          AvantePromptInputBorder = { bg = c.avante.prompt_bg, fg = c.avante.prompt_border },
          AvantePopupHint = { bg = c.avante.popup_bg, fg = c.avante.sidebar_fg },
          AvanteInlineHint = { fg = c.avante.inline_hint, italic = true },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                         Avante Titles                             │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteTitle = { fg = c.avante.title_fg, bg = c.avante.title_bg, bold = true },
          AvanteReversedTitle = { fg = c.avante.title_bg, bg = c.avante.title_fg },
          AvanteSubtitle = { fg = c.avante.subtitle_fg, bg = c.avante.subtitle_bg, bold = true },
          AvanteReversedSubtitle = { fg = c.avante.subtitle_bg, bg = c.avante.subtitle_fg },
          AvanteThirdTitle = { fg = c.avante.third_title_fg, bg = c.avante.third_title_bg, bold = true },
          AvanteReversedThirdTitle = { fg = c.avante.third_title_bg, bg = c.avante.title_fg },
          AvanteConfirmTitle = { fg = c.avante.title_fg, bg = c.avante.confirm_title_bg, bold = true },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                         Avante Buttons                            │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteButtonDefault = { fg = c.avante.title_fg, bg = c.avante.button_default_bg },
          AvanteButtonDefaultHover = { fg = c.avante.title_fg, bg = c.avante.button_hover_bg },
          AvanteButtonPrimary = { fg = c.avante.title_fg, bg = c.avante.button_primary_bg },
          AvanteButtonPrimaryHover = { fg = c.avante.title_fg, bg = c.avante.button_primary_hover_bg },
          AvanteButtonDanger = { fg = c.avante.title_fg, bg = c.avante.button_default_bg },
          AvanteButtonDangerHover = { fg = c.avante.title_fg, bg = c.avante.button_danger_hover_bg },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                       Avante Diff/Conflict                        │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteConflictCurrent = { bg = c.diff.add, bold = true },
          AvanteConflictCurrentLabel = { fg = c.accent.green, bg = c.diff.add, bold = true },
          AvanteConflictIncoming = { bg = c.diff.change, bold = true },
          AvanteConflictIncomingLabel = { fg = c.accent.blue, bg = c.diff.change, bold = true },
          AvanteToBeDeleted = { bg = c.diff.delete, strikethrough = true },
          AvanteToBeDeletedWOStrikethrough = { bg = c.diff.delete },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      Avante State Spinners                        │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteStateSpinnerGenerating = { fg = c.avante.title_fg, bg = c.avante.spinner_generating },
          AvanteStateSpinnerThinking = { fg = c.avante.title_fg, bg = c.avante.spinner_generating },
          AvanteStateSpinnerToolCalling = { fg = c.avante.title_fg, bg = c.avante.spinner_tool_calling },
          AvanteStateSpinnerSearching = { fg = c.avante.title_fg, bg = c.avante.spinner_generating },
          AvanteStateSpinnerCompacting = { fg = c.avante.title_fg, bg = c.avante.spinner_generating },
          AvanteStateSpinnerSucceeded = { fg = c.avante.title_fg, bg = c.avante.spinner_succeeded },
          AvanteStateSpinnerFailed = { fg = c.avante.title_fg, bg = c.avante.spinner_failed },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                        Avante Task Status                         │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteTaskRunning = { fg = c.avante.task_running, bg = c.avante.sidebar_bg },
          AvanteTaskCompleted = { fg = c.avante.task_completed, bg = c.avante.sidebar_bg },
          AvanteTaskFailed = { fg = c.avante.task_failed, bg = c.avante.sidebar_bg },
          AvanteThinking = { fg = c.avante.task_running, bg = c.avante.sidebar_bg },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                          Avante Misc                              │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteSuggestion = { fg = c.avante.suggestion, italic = true },
          AvanteAnnotation = { fg = c.avante.annotation, italic = true },
          AvanteCommentFg = { fg = c.avante.suggestion },
          AvanteReversedNormal = { fg = c.avante.title_fg, bg = c.avante.sidebar_fg },
          AvanteSidebarWinSeparator = { fg = c.avante.separator, bg = c.avante.sidebar_bg },
          AvanteSidebarWinHorizontalSeparator = { fg = c.avante.separator, bg = c.avante.sidebar_bg },

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      Snacks Picker/Explorer                       │
          -- └──────────────────────────────────────────────────────────────────┘
          SnacksPickerNormal = { bg = c.snacks.normal_bg, fg = c.snacks.normal_fg },
          SnacksPickerBorder = { bg = c.snacks.normal_bg, fg = c.snacks.border },
          SnacksPickerTitle = { bg = c.snacks.title_bg, fg = c.snacks.title_fg, bold = true },
          SnacksPickerInput = { bg = c.snacks.input_bg, fg = c.snacks.input_fg },
          SnacksPickerInputBorder = { bg = c.snacks.input_bg, fg = c.snacks.border },
          SnacksPickerList = { bg = c.snacks.list_bg, fg = c.snacks.normal_fg },
          SnacksPickerListCursorLine = { bg = c.snacks.selection_bg },
          SnacksPickerPreview = { bg = c.snacks.preview_bg, fg = c.snacks.normal_fg },
          SnacksPickerPreviewBorder = { bg = c.snacks.preview_bg, fg = c.snacks.border },
          SnacksPickerMatch = { fg = c.snacks.match_fg, bold = true },
          SnacksPickerDir = { fg = c.snacks.dir_fg },
          SnacksPickerFile = { fg = c.snacks.file_fg },

          -- Snacks Explorer specific
          SnacksExplorerNormal = { bg = c.snacks.normal_bg, fg = c.snacks.normal_fg },
          SnacksExplorerBorder = { bg = c.snacks.normal_bg, fg = c.snacks.border },
          SnacksExplorerTitle = { bg = c.snacks.title_bg, fg = c.snacks.title_fg, bold = true },

          -- Snacks Notifier
          SnacksNotifierNormal = { bg = c.snacks.normal_bg, fg = c.snacks.normal_fg },
          SnacksNotifierBorder = { bg = c.snacks.normal_bg, fg = c.snacks.border },

          -- Snacks Input
          SnacksInputNormal = { bg = c.snacks.input_bg, fg = c.snacks.input_fg },
          SnacksInputBorder = { bg = c.snacks.input_bg, fg = c.snacks.border },
          SnacksInputTitle = { bg = c.snacks.title_bg, fg = c.snacks.title_fg, bold = true },
        },
      })
      -- Enable theme
      require("onedark").load()
    end,
  },
}
