-- Standalone render-markdown config for proper Avante integration
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "Avante" },
  opts = {
    file_types = { "markdown", "Avante" },
    render_modes = { "n", "c", "t", "i" }, -- Render in all modes including insert
    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        sign = true,
      },
    },
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
    },
    code = {
      enabled = true,
      sign = false,
      style = "full", -- full, normal, language, none
      position = "left",
      width = "full",
      border = "thin",
      highlight = "RenderMarkdownCode",
      highlight_language = nil,
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },
    quote = {
      enabled = true,
      icon = "▋",
    },
    pipe_table = {
      enabled = true,
      style = "full",
    },
    win_options = {
      conceallevel = { rendered = 2, default = 0 },
      concealcursor = { rendered = "nc", default = "" },
    },
    overrides = {
      filetype = {
        Avante = {
          render_modes = { "n", "c", "t", "i" },
          code = {
            style = "full",
            border = "thin",
          },
        },
      },
    },
    -- DARC: render control codes in place of {{uuid}} refs. Plugging into
    -- render-markdown's pipeline (instead of our own extmarks) lets one system
    -- own conceal + anti_conceal, so there's no cursor-line flicker.
    custom_handlers = {
      markdown = {
        extends = true,
        parse = function(ctx)
          return require("r4k4210.darc_uuid").rm_parse(ctx)
        end,
      },
    },
  },
}
