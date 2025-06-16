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
      -- default_prompt = "default",
      template_dir = vim.fn.stdpath("config") .. "/lua/r4k4210/llm/templates",
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "openrouter" | string
      provider = "openrouter", -- Using OpenRouter as the default provider

      providers = {
        copilot = false,
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "anthropic/claude-sonnet-4",
          -- Configuraciones específicas para evitar problemas con edit mode
          timeout = 60000, -- Timeout más largo para edit mode
          max_tokens = 8192, -- Límite de tokens para evitar respuestas muy largas
          -- Tools específicamente habilitadas para edit mode
          -- disabled_tools = {}, -- Mantener todas las herramientas habilitadas
        },
      },
      ---Configuración dual_boost experimental
      dual_boost = {
        enabled = false, -- Deshabilitado por defecto
        first_provider = "openrouter",
        second_provider = "claude",
        prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
        timeout = 60000,
      },
      web_search_engine = {
        provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
        proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
      },
      rag_service = {
        enabled = false, -- Habilitar el servicio RAG
        host_mount = os.getenv("HOME"), -- Ruta de montaje del host para el servicio RAG
        runner = "docker", -- Runner para el servicio RAG (docker o nix)
        llm = {
          provider = "openrouter",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "anthropic/claude-3-sonnet",
        },
        embed = {
          provider = "openai",
          endpoint = "https://api.openai.com/v1",
          api_key_name = "OPENAI_API_KEY",
          model = "text-embedding-3-large",
        },
        docker_extra_args = "", -- Argumentos extra para el comando docker
      },
      behaviour = {
        auto_suggestions = false, -- Experimental feature
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Removes unchanged lines when applying a code block
        enable_token_counting = false, -- Enables token counting (default: true) | Esto previene que ande lento al escribir
        enable_cursor_planning_mode = true, -- Habilitar Cursor Planning Mode para mejor compatibilidad
        auto_approve_tool_permissions = false, -- Mostrar prompts de permisos para herramientas
        streaming = false, -- CRÍTICO: Deshabilitar streaming para evitar crashes con OpenRouter
      },
      history = {
        max_tokens = 50000, -- Límite de tokens para el historial (reducido)
        storage_path = vim.fn.stdpath("state") .. "/avante", -- Donde guardar el historial
        max_files = 5, -- Máximo número de archivos de historial (reducido)
      },
      -- Configuración para limitar el contexto del RAG
      context = {
        max_files = 5, -- Máximo número de archivos a incluir en el contexto
        max_lines_per_file = 100, -- Máximo número de líneas por archivo
        max_total_tokens = 100000, -- Límite total de tokens para el contexto
      },
      --- @class AvanteRepoMapConfig
      repo_map = {
        ignore_patterns = { "%.env.*", "^%.env$", "%.git", "%.worktree", "__pycache__", "node_modules" }, -- ignore files matching these
        negate_patterns = {}, -- negate ignore files matching these.
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
        confirm = {
          focus_window = "<C-w>f",
          code = "c",
          resp = "r",
          input = "i",
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

      selector = {
        provider = "snacks", -- "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope"
      },

      -- Configuración de input mejorada
      input = {
        provider = "dressing", -- "native" | "dressing" | "snacks"
        provider_opts = {},
      },

      -- Herramientas deshabilitadas si es necesario
      disabled_tools = {}, -- Lista de herramientas a deshabilitar, ej: {"python", "bash"}

      -- Configuración de tools personalizada
      custom_tools = {
        -- Aquí puedes agregar herramientas personalizadas en el futuro
      },
    })

    -- -- Autocommand to toggle custom system prompt
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "ToggleMyPrompt",
    --   callback = function()
    --     -- Load system prompt from external file
    --     local prompt_file = vim.fn.stdpath("config") .. "/lua/r4k4210/llm/system_prompt.lua"
    --     local ok, system_prompt = pcall(dofile, prompt_file)
    --
    --     -- Apply new system prompt if loading was successful
    --     if ok and type(system_prompt) == "string" then
    --       require("avante.config").override({ system_prompt = system_prompt })
    --       print("Custom system prompt loaded:\n" .. system_prompt) -- 🔹 Verify if loaded correctly
    --       vim.notify("Custom system prompt loaded", vim.log.levels.INFO)
    --     else
    --       print("Failed to load system prompt from file")
    --       vim.notify("Failed to load system prompt from file", vim.log.levels.ERROR)
    --     end
    --   end,
    -- })
    --
    -- -- Keybinding to trigger prompt change
    -- vim.keymap.set("n", "<leader>am", function()
    --   vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
    -- end, { desc = "avante: toggle my prompt" })
  end,
}
