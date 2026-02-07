local providers = require("r4k4210.plugins.avante.providers")
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
    "MeanderingProgrammer/render-markdown.nvim", -- Configured in render-markdown.lua
  },
  config = function()
    require("avante").setup({
      -- default_prompt = "default",
      template_dir = vim.fn.stdpath("config") .. "/lua/r4k4210/llm/templates",
      provider = "openrouter-gpt5", -- Switch to "claude-code" for agentic mode
      providers = providers,

      -- ACP (Agent Client Protocol) providers for agentic capabilities
      acp_providers = {
        ["claude-code"] = {
          command = "npx",
          args = { "@zed-industries/claude-code-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN"),
          },
        },
        ["gemini-cli"] = {
          command = "gemini",
          args = { "--experimental-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
          },
        },
        ["codex"] = {
          command = "npx",
          args = { "@zed-industries/codex-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
          },
        },
      },
      -- Removed dual_boost configuration to prevent conflicts
      web_search_engine = {
        provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
        proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
      },
      behaviour = behaviour,
      history = {
        max_tokens = 15000, -- Límite de tokens para el historial (optimizado para rendimiento)
        storage_path = vim.fn.stdpath("state") .. "/avante", -- Donde guardar el historial
        max_files = 5, -- Máximo número de archivos de historial
      },
      -- Configuración para limitar el contexto del RAG
      context = {
        max_files = 5, -- Máximo número de archivos a incluir en el contexto
        max_lines_per_file = 100, -- Máximo número de líneas por archivo
        max_total_tokens = 30000, -- Límite total de tokens para el contexto (optimizado)
      },
      --- @class AvanteRepoMapConfig
      repo_map = {
        ignore_patterns = { "%.env.*", "^%.env$", "%.git", "%.worktree", "__pycache__", "node_modules" }, -- ignore files matching these
        negate_patterns = {}, -- negate ignore files matching these.
      },
      mappings = mappings,
      hints = { enabled = false }, -- Disabled to avoid duplicate UI with inline buttons
      windows = windows,
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "AvanteConflictCurrent",
          incoming = "AvanteConflictIncoming",
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

      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function(opts)
        -- Disable MCP prompts for OpenRouter providers
        if opts and opts.provider and opts.provider:match("^openrouter%-") then
          return ""
        end
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,

      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function(opts)
        -- Disable MCP tools for OpenRouter providers
        if opts and opts.provider and opts.provider:match("^openrouter%-") then
          return {}
        end
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,

      disabled_tools = { -- Lista de herramientas a deshabilitar, ej: {"python", "bash"}
        "list_files", -- Built-in file operations
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash", -- Built-in terminal access
        "view", -- Redundant since you can see the file in the editor
      },
    })
  end,
}
