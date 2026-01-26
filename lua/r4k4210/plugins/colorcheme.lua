return {
  -- {
  --   "bluz71/vim-nightfly-guicolors",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme nightfly]])
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     local catppuccin = require("catppuccin")
  --
  --     catppuccin.setup({
  --       flavour = "mocha",
  --       highlights = require("catppuccin.groups.integrations.bufferline").get(),
  --       integrations = {
  --         cmp = true,
  --         treesitter = true,
  --         neotree = false,
  --         notify = false,
  --         noice = true,
  --         alpha = true,
  --         telescope = {
  --           enabled = true,
  --         },
  --         mini = {
  --           enabled = true,
  --           indentscope_color = "",
  --         },
  --       },
  --     })
  --
  --     vim.cmd([[colorscheme catppuccin]])
  --   end,
  -- },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "deep", -- dark, darker, cool, warmer, dark, warm
        highlights = {
          -- ╔══════════════════════════════════════════════════════════════════╗
          -- ║                    OneDark Deep Palette Reference                 ║
          -- ╠══════════════════════════════════════════════════════════════════╣
          -- ║ bg_d=#141b24  bg0=#1a212e  bg1=#21283b  bg2=#283347  bg3=#2a324a  ║
          -- ║ fg=#93a4c3  grey=#455574  light_grey=#6c7d9c                      ║
          -- ║ red=#f65866  green=#8bcd5b  yellow=#efbd5d  blue=#41a7fc          ║
          -- ║ purple=#c75ae8  cyan=#34bfd0  orange=#dd9046                      ║
          -- ║ diff_add=#27341c  diff_delete=#331c1e  diff_change=#102b40        ║
          -- ╚══════════════════════════════════════════════════════════════════╝

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      render-markdown highlights                   │
          -- └──────────────────────────────────────────────────────────────────┘
          RenderMarkdownH1Bg = { bg = "#283347" }, -- bg2
          RenderMarkdownH2Bg = { bg = "#252d3d" }, -- between bg1 and bg2
          RenderMarkdownH3Bg = { bg = "#21283b" }, -- bg1
          RenderMarkdownH4Bg = { bg = "#1e2430" }, -- between bg0 and bg1
          RenderMarkdownH5Bg = { bg = "#1a212e" }, -- bg0
          RenderMarkdownH6Bg = { bg = "#171c26" }, -- between bg0 and bg_d
          RenderMarkdownCode = { bg = "#141b24" }, -- bg_d (darker)
          RenderMarkdownCodeInline = { bg = "#21283b" }, -- bg1

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      Avante Sidebar & Input                       │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteSidebarNormal = { bg = "#1a212e", fg = "#93a4c3" }, -- bg0, fg
          AvantePromptInput = { bg = "#1a212e", fg = "#93a4c3" }, -- bg0, fg
          AvantePromptInputBorder = { bg = "#1a212e", fg = "#455574" }, -- bg0, grey
          AvantePopupHint = { bg = "#21283b", fg = "#93a4c3" }, -- bg1, fg
          AvanteInlineHint = { fg = "#c75ae8", italic = true }, -- purple

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                         Avante Titles                             │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteTitle = { fg = "#1a212e", bg = "#8bcd5b", bold = true }, -- bg0, green
          AvanteReversedTitle = { fg = "#8bcd5b", bg = "#1a212e" }, -- green, bg0
          AvanteSubtitle = { fg = "#1a212e", bg = "#34bfd0", bold = true }, -- bg0, cyan
          AvanteReversedSubtitle = { fg = "#34bfd0", bg = "#1a212e" }, -- cyan, bg0
          AvanteThirdTitle = { fg = "#93a4c3", bg = "#2a324a", bold = true }, -- fg, bg3
          AvanteReversedThirdTitle = { fg = "#2a324a", bg = "#1a212e" }, -- bg3, bg0
          AvanteConfirmTitle = { fg = "#1a212e", bg = "#f65866", bold = true }, -- bg0, red

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                         Avante Buttons                            │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteButtonDefault = { fg = "#1a212e", bg = "#6c7d9c" }, -- bg0, light_grey
          AvanteButtonDefaultHover = { fg = "#1a212e", bg = "#8bcd5b" }, -- bg0, green
          AvanteButtonPrimary = { fg = "#1a212e", bg = "#41a7fc" }, -- bg0, blue
          AvanteButtonPrimaryHover = { fg = "#1a212e", bg = "#34bfd0" }, -- bg0, cyan
          AvanteButtonDanger = { fg = "#1a212e", bg = "#6c7d9c" }, -- bg0, light_grey
          AvanteButtonDangerHover = { fg = "#1a212e", bg = "#f65866" }, -- bg0, red

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                       Avante Diff/Conflict                        │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteConflictCurrent = { bg = "#27341c", bold = true }, -- diff_add
          AvanteConflictCurrentLabel = { fg = "#8bcd5b", bg = "#27341c", bold = true }, -- green
          AvanteConflictIncoming = { bg = "#102b40", bold = true }, -- diff_change
          AvanteConflictIncomingLabel = { fg = "#41a7fc", bg = "#102b40", bold = true }, -- blue
          AvanteToBeDeleted = { bg = "#331c1e", strikethrough = true }, -- diff_delete
          AvanteToBeDeletedWOStrikethrough = { bg = "#331c1e" }, -- diff_delete

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                      Avante State Spinners                        │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteStateSpinnerGenerating = { fg = "#1a212e", bg = "#c75ae8" }, -- bg0, purple
          AvanteStateSpinnerThinking = { fg = "#1a212e", bg = "#c75ae8" }, -- bg0, purple
          AvanteStateSpinnerToolCalling = { fg = "#1a212e", bg = "#34bfd0" }, -- bg0, cyan
          AvanteStateSpinnerSearching = { fg = "#1a212e", bg = "#c75ae8" }, -- bg0, purple
          AvanteStateSpinnerCompacting = { fg = "#1a212e", bg = "#c75ae8" }, -- bg0, purple
          AvanteStateSpinnerSucceeded = { fg = "#1a212e", bg = "#8bcd5b" }, -- bg0, green
          AvanteStateSpinnerFailed = { fg = "#1a212e", bg = "#f65866" }, -- bg0, red

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                        Avante Task Status                         │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteTaskRunning = { fg = "#c75ae8", bg = "#1a212e" }, -- purple, bg0
          AvanteTaskCompleted = { fg = "#8bcd5b", bg = "#1a212e" }, -- green, bg0
          AvanteTaskFailed = { fg = "#f65866", bg = "#1a212e" }, -- red, bg0
          AvanteThinking = { fg = "#c75ae8", bg = "#1a212e" }, -- purple, bg0

          -- ┌──────────────────────────────────────────────────────────────────┐
          -- │                          Avante Misc                              │
          -- └──────────────────────────────────────────────────────────────────┘
          AvanteSuggestion = { fg = "#455574", italic = true }, -- grey
          AvanteAnnotation = { fg = "#455574", italic = true }, -- grey
          AvanteCommentFg = { fg = "#455574" }, -- grey
          AvanteReversedNormal = { fg = "#1a212e", bg = "#93a4c3" }, -- bg0, fg
          AvanteSidebarWinSeparator = { fg = "#455574", bg = "#1a212e" }, -- grey, bg0
          AvanteSidebarWinHorizontalSeparator = { fg = "#455574", bg = "#1a212e" }, -- grey, bg0
        },
      })
      -- Enable theme
      require("onedark").load()
    end,
  },
}
