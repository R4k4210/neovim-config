return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
    })

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr
      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    vim.diagnostic.config({
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "󰠠",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      underline = false,
      update_in_insert = false,
      severity_sort = false,
    })

    --- LSP setup with vim.lsp.config (Neovim 0.11+)
    local setup = function(server, config)
      vim.lsp.config(
        server,
        vim.tbl_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, config or {})
      )
    end

    setup("html")
    setup("eslint")
    setup("ts_ls")
    setup("cssls")
    setup("tailwindcss")
    setup("prismals")
    setup("graphql", {
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })
    setup("emmet_ls", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })
    setup("pyright")
    setup("black")
    setup("gopls", {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })
    setup("clangd")
    setup("arduino_language_server", {
      cmd = {
        "arduino-language-server",
        "-cli-config",
        "~/.arduinoIDE/arduino-cli.yaml",
        "-fqbn",
        "arduino:avr:uno",
      },
    })
    setup("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
    setup("svelte", {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end,
    })

    -- Conditional LSP loading based on filetype for better performance
    local conditional_servers = {
      javascript = { "ts_ls", "eslint" },
      typescript = { "ts_ls", "eslint" },
      javascriptreact = { "ts_ls", "eslint" },
      typescriptreact = { "ts_ls", "eslint" },
      html = { "html", "emmet_ls", "tailwindcss" },
      css = { "cssls", "tailwindcss" },
      scss = { "cssls", "tailwindcss" },
      sass = { "cssls", "tailwindcss" },
      less = { "cssls", "tailwindcss" },
      python = { "pyright" },
      go = { "gopls" },
      lua = { "lua_ls" },
      c = { "clangd" },
      cpp = { "clangd" },
      arduino = { "arduino_language_server" },
      svelte = { "svelte", "ts_ls", "eslint" },
      graphql = { "graphql" },
      prisma = { "prismals" },
    }

    -- Enable LSP servers conditionally based on filetype
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local filetype = args.match
        local servers_for_ft = conditional_servers[filetype]

        if servers_for_ft then
          for _, server in ipairs(servers_for_ft) do
            vim.lsp.enable(server)
          end
        end
      end,
    })

    -- Always enable essential servers for common usage
    local always_enabled = { "lua_ls" } -- Lua for Neovim config
    for _, server in ipairs(always_enabled) do
      vim.lsp.enable(server)
    end
  end,
}
