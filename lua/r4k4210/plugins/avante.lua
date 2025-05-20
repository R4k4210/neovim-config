return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  build = "make", -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for Windows
  dependencies = {
    "stevearc/dressing.nvim", -- UI enhancements for input/select dialogs
    "nvim-lua/plenary.nvim", -- Useful Lua functions used by many plugins
    "MunifTanjim/nui.nvim", -- UI components for Neovim
    --- Optional dependencies
    "hrsh7th/nvim-cmp", -- Autocompletion for Avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- Icons for UI
    "zbirenbaum/copilot.lua", -- Used when providers='copilot'
    {
      -- Support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- Recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- Required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Markdown rendering support
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function()
    -- Basic setup with default options
    require("avante").setup({
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "openrouter" | string
      provider = "openai", -- Using OpenRouter as the default provider
      -- WARNING: Setting `auto_suggestions_provider = "copilot"` can be expensive due to frequent API requests
      cursor_applying_provider = nil, -- Provider for applying phase in Cursor Planning Mode (defaults to provider)
      openai = {
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "anthropic/claude-3.5-sonnet",
        temperature = 0.0,
        max_tokens = 4096,
      },
      -- vendors = {
      --   openrouter = {
      --     endpoint = "https://openrouter.ai/api/v1",
      --     api_key_name = "OPENROUTER_API_KEY",
      --     model = "anthropic/claude-3.5-sonnet",
      --     temperature = 0.0,
      --     max_tokens = 4096,
      --   },
      -- },
      behaviour = {
        auto_suggestions = false, -- Experimental feature
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Removes unchanged lines when applying a code block
        enable_token_counting = true, -- Enables token counting (default: true)
        enable_cursor_planning_mode = false, -- Enables Cursor Planning Mode (default: false)
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "left", -- Sidebar position
        wrap = true, -- Similar to vim.o.wrap
        width = 30, -- Default width percentage
        sidebar_header = {
          enabled = true, -- Enables/disables sidebar header
          align = "center", -- Title alignment: left, center, or right
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8, -- Input window height in vertical layout
        },
        edit = {
          border = "rounded",
          start_insert = true, -- Start in insert mode when opening edit window
        },
        ask = {
          floating = false, -- Opens 'AvanteAsk' prompt in a floating window
          start_insert = true, -- Start in insert mode when opening ask window
          border = "rounded",
          ---@type "ours" | "theirs"
          focus_on_apply = "ours", -- Which diff to focus on after applying
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen", -- Opens conflict list in quickfix window
        --- Overrides 'timeoutlen' while hovering over a diff
        override_timeoutlen = 500,
      },
      suggestion = {
        debounce = 600, -- Delay before showing suggestions
        throttle = 600, -- Minimum time between suggestions
      },
    })

    -- Autocommand to toggle custom system prompt
    vim.api.nvim_create_autocmd("User", {
      pattern = "ToggleMyPrompt",
      callback = function()
        -- Load system prompt from external file
        local prompt_file = vim.fn.stdpath("config") .. "/lua/r4k4210/llm/system_prompt.lua"
        local ok, system_prompt = pcall(dofile, prompt_file)

        -- Apply new system prompt if loading was successful
        if ok and type(system_prompt) == "string" then
          require("avante.config").override({ system_prompt = system_prompt })
          print("Custom system prompt loaded:\n" .. system_prompt) -- 🔹 Verify if loaded correctly
          vim.notify("Custom system prompt loaded", vim.log.levels.INFO)
        else
          print("Failed to load system prompt from file")
          vim.notify("Failed to load system prompt from file", vim.log.levels.ERROR)
        end
      end,
    })

    -- Keybinding to trigger prompt change
    vim.keymap.set("n", "<leader>am", function()
      vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
    end, { desc = "avante: toggle my prompt" })
  end,
}
