local providers = require("r4k4210.plugins.avante.providers")
local rag_service = require("r4k4210.plugins.avante.rag_service")
local mappings = require("r4k4210.plugins.avante.mappings")
local windows = require("r4k4210.plugins.avante.windows")
local behaviour = require("r4k4210.plugins.avante.behaviour")

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
    require("avante").setup({
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,

      -- default_prompt = "default",
      template_dir = vim.fn.stdpath("config") .. "/lua/r4k4210/llm/templates",
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "openrouter" | string
      provider = "openrouter", -- Using OpenRouter as the default provider

      providers = providers,
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
      rag_service = rag_service,
      behaviour = behaviour,
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
      mappings = mappings,
      hints = { enabled = true },
      windows = windows,
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
