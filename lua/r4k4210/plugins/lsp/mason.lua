return {
  -- Mason: Portable package manager for Neovim
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Import Mason plugins
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- Configure Mason with improved UI
    mason.setup({
      ui = {
        -- Enhanced icons for better visual feedback
        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },
        border = "rounded",
        width = 0.8,
        height = 0.9,
      },
      -- Performance settings
      max_concurrent_installers = 4,
      log_level = vim.log.levels.INFO,
    })

    -- Configure Mason-LSPConfig with v2.0.0 settings
    mason_lspconfig.setup({
      -- Servers to automatically install
      ensure_installed = {
        "ts_ls", -- TypeScript/JavaScript
        "html", -- HTML
        "cssls", -- CSS
        "tailwindcss", -- Tailwind CSS
        "svelte", -- Svelte
        "lua_ls", -- Lua
        "graphql", -- GraphQL
        "emmet_ls", -- Emmet
        "prismals", -- Prisma
        "pyright", -- Python
        "eslint", -- ESLint
        "clangd", -- C/C++
        "arduino_language_server", -- Arduino
      },
      -- Auto-enable installed servers (v2.0.0 feature)
      automatic_enable = true, -- Updated from automatic_installation
    })

    -- Configure Mason Tool Installer for formatters and linters
    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettier", -- JavaScript/TypeScript/HTML/CSS
        "prettierd", -- Faster prettier daemon
        "stylua", -- Lua formatter
        "isort", -- Python import sorter
        "black", -- Python formatter
        -- Linters
        "eslint", -- JavaScript/TypeScript linter
        "pylint", -- Python linter
        -- Debug Adapters
        "js-debug-adapter", -- JavaScript/TypeScript debugger
      },
      -- Auto-update tools
      auto_update = false,
      run_on_start = true,
    })
  end,
}
