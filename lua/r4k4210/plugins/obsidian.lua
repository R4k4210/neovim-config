return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Opcionales (podés sacarlos si no querés):
    "hrsh7th/nvim-cmp", -- autocompletado
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = vim.fn.expand("~/_dev/_personal/obsidian/vaults"),
      },
      {
        name = "work",
        path = vim.fn.expand("~/_dev/_work/obsidian/vaults"),
      },
    },

    --- Opciones generales ---
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily.md",
    },

    completion = {
      nvim_cmp = true, -- activa autocompletado con nvim-cmp
      min_chars = 2,
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    notes_subdir = "notes", -- subcarpeta default para notas nuevas

    --- UI ---
    ui = {
      enable = true,
      update_debounce = 200,
      checkboxes = {
        -- podés personalizar checkboxes estilo Obsidian
        [" "] = { char = "⬜", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" },
      },
    },
  },
}
