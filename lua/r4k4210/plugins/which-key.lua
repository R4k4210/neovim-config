return {
  -- Which-key: Key binding help popup
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- Modern preset for better visual experience
    preset = "modern",
    -- Delay before showing the popup
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    -- Configure triggers manually to avoid conflicts
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
    -- Allow which-key to work in terminal buffers (normal mode)
    filter = function(mapping)
      return true
    end,
    -- Enhanced plugins configuration
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false, -- Disable operator help
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    -- Better window configuration
    win = {
      border = "rounded",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
    },
    -- Icon configuration
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      mappings = true,
      colors = true,
    },
    -- Key mappings specification
    spec = {
      {
        "<leader>b",
        group = "Buffers",
        icon = "󰓩",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      { "<leader>c", group = "Colors & Rename", icon = "🎨" },
      { "<leader>f", group = "Find & Files", icon = "󰈞" },
      { "<leader>g", group = "Git", icon = "󰊢" },
      { "<leader>m", group = "Tools & Format", icon = "🔧" },
      { "<leader>a", group = "Avante AI", icon = "🤖" },
      { "<leader>aa", desc = "Ask", icon = "💬" },
      { "<leader>at", desc = "Toggle sidebar", icon = "📋" },
      { "<leader>ae", desc = "Edit", icon = "✏️" },
      { "<leader>ac", desc = "Clear chat", icon = "🗑️" },
      { "<leader>af", desc = "Focus input", icon = "🎯" },
      { "<leader>ar", desc = "Refresh", icon = "🔄" },
      { "<leader>as", desc = "Stop generation", icon = "⏹️" },
      { "<leader>ap", desc = "Switch provider", icon = "🔀" },
      { "<leader>s", group = "Search & Symbols", icon = "󰍉" },
      { "<leader>t", group = "Terminal", icon = "󰆍" },
      { "<leader>u", group = "UI Toggles", icon = "󰍉" },
      { "<leader>d", group = "Debug", icon = "🐛" },
      -- Hidden mappings
      { "<leader>n", hidden = true },
      { "<leader>p", hidden = true },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
