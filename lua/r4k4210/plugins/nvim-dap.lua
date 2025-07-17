return {
  -- Debug Adapter Protocol client for Neovim
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup nvim-dap-ui
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Expand lines larger than the window
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      -- Layouts define sections of the screen to place windows.
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "↻",
          terminate = "□",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    })

    -- Setup nvim-dap-virtual-text
    require("nvim-dap-virtual-text").setup({
      enabled = true, -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true, -- show stop reason when stopped for exceptions
      commented = false, -- prefix virtual text with comment string
      only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
      all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
      --- A callback that determines how a variable is displayed or whether it should be omitted
      display_callback = function(variable, _, _, _, options)
        if options.virt_text_pos == "inline" then
          return " = " .. variable.value
        else
          return variable.name .. " = " .. variable.value
        end
      end,
      -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

      -- experimental features:
      all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    })

    -- Configure TypeScript/JavaScript debugging with node2
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    -- TypeScript/JavaScript configurations
    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        resolveSourceMapLocations = {
          "${workspaceFolder}/dist/**/*.js",
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**/*.js" },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**/*.js" },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Vitest Tests",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/vitest/vitest.mjs",
          "run",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**/*.js" },
      },
      -- React Development Server debugging
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug React Dev Server (npm start)",
        runtimeExecutable = "npm",
        runtimeArgs = { "start" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
          BROWSER = "none", -- Disable auto browser opening
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/src/**",
          "!**/node_modules/**",
        },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug React Dev Server (yarn start)",
        runtimeExecutable = "yarn",
        runtimeArgs = { "start" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
          BROWSER = "none",
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/src/**",
          "!**/node_modules/**",
        },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug React Dev Server (pnpm start)",
        runtimeExecutable = "pnpm",
        runtimeArgs = { "start" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
          BROWSER = "none",
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/src/**",
          "!**/node_modules/**",
        },
      },
      -- React Testing Library debugging
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug React Tests (Jest)",
        runtimeExecutable = "npm",
        runtimeArgs = {
          "test",
          "--",
          "--runInBand",
          "--no-coverage",
          "--watchAll=false",
        },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**/*.js" },
        env = {
          CI = "true", -- Disable watch mode
        },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Current React Test File",
        runtimeExecutable = "npm",
        runtimeArgs = {
          "test",
          "--",
          "--runInBand",
          "--no-coverage",
          "--watchAll=false",
          "${relativeFile}",
        },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**/*.js" },
        env = {
          CI = "true",
        },
      },
      -- Next.js debugging
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Next.js Dev Server",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
      -- Vite React debugging (npm)
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Vite React Dev Server (npm)",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/src/**",
          "!**/node_modules/**",
        },
      },
      -- Vite React debugging (pnpm)
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Vite React Dev Server (pnpm)",
        runtimeExecutable = "pnpm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/src/**",
          "!**/node_modules/**",
        },
      },
      -- Vite React debugging (yarn)
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Vite React Dev Server (yarn)",
        runtimeExecutable = "yarn",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        env = {
          NODE_ENV = "development",
        },
        skipFiles = { "<node_internals>/**/*.js" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/src/**",
          "!**/node_modules/**",
        },
      },
    }

    -- JavaScript configurations (same as TypeScript)
    dap.configurations.javascript = dap.configurations.typescript

    -- React TypeScript configurations (.tsx files)
    dap.configurations.typescriptreact = dap.configurations.typescript

    -- React JavaScript configurations (.jsx files)
    dap.configurations.javascriptreact = dap.configurations.typescript

    -- Auto open/close dapui
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Set breakpoint icons
    vim.fn.sign_define("DapBreakpoint", {
      text = "🔴",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpointLine",
      numhl = "DapBreakpointNum",
    })
    vim.fn.sign_define("DapStopped", {
      text = "🟢",
      texthl = "DapStopped",
      linehl = "DapStoppedLine",
      numhl = "DapStoppedNum",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "🟡",
      texthl = "DapBreakpointCondition",
      linehl = "DapBreakpointConditionLine",
      numhl = "DapBreakpointConditionNum",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "🚫",
      texthl = "DapBreakpointRejected",
      linehl = "DapBreakpointRejectedLine",
      numhl = "DapBreakpointRejectedNum",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = "📝",
      texthl = "DapLogPoint",
      linehl = "DapLogPointLine",
      numhl = "DapLogPointNum",
    })

    -- Key mappings for debugging
    vim.keymap.set("n", "<Leader>dc", function()
      -- Si no hay sesión activa, mostrar selector de configuración
      if not dap.session() then
        -- Forzar la selección de configuración
        local configs = dap.configurations[vim.bo.filetype]
        if configs and #configs > 0 then
          -- Usar vim.ui.select para mostrar las opciones
          local config_names = {}
          for i, config in ipairs(configs) do
            table.insert(config_names, i .. ". " .. config.name)
          end

          vim.ui.select(config_names, {
            prompt = "Select debug configuration:",
            format_item = function(item)
              return item
            end,
          }, function(choice, idx)
            if choice and idx then
              -- Ejecutar la configuración seleccionada
              dap.run(configs[idx])
            end
          end)
        else
          vim.notify("No debug configurations found for filetype: " .. vim.bo.filetype, vim.log.levels.WARN)
        end
      else
        -- Si ya hay sesión activa, continuar
        dap.continue()
      end
    end, { desc = "DAP: Continue/Start Debug" })
    vim.keymap.set("n", "<Leader>do", function()
      dap.step_over()
    end, { desc = "DAP: Step Over" })
    vim.keymap.set("n", "<Leader>di", function()
      dap.step_into()
    end, { desc = "DAP: Step Into" })
    vim.keymap.set("n", "<Leader>dO", function()
      dap.step_out()
    end, { desc = "DAP: Step Out" })
    vim.keymap.set("n", "<Leader>db", function()
      dap.toggle_breakpoint()
    end, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint()
    end, { desc = "DAP: Set Breakpoint" })
    vim.keymap.set("n", "<Leader>dlp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "DAP: Log Point" })
    vim.keymap.set("n", "<Leader>dr", function()
      dap.repl.open()
    end, { desc = "DAP: Open REPL" })
    vim.keymap.set("n", "<Leader>dl", function()
      dap.run_last()
    end, { desc = "DAP: Run Last" })
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "DAP: Hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
      require("dap.ui.widgets").preview()
    end, { desc = "DAP: Preview" })
    vim.keymap.set("n", "<Leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, { desc = "DAP: Frames" })
    vim.keymap.set("n", "<Leader>ds", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end, { desc = "DAP: Scopes" })

    -- DAP UI Toggle
    vim.keymap.set("n", "<Leader>du", function()
      dapui.toggle()
    end, { desc = "DAP: Toggle UI" })

    -- DAP Commands using native Neovim commands
    vim.keymap.set("n", "<Leader>dcc", '<cmd>lua require("dap").run_to_cursor()<cr>', { desc = "DAP: Run to Cursor" })
    vim.keymap.set(
      "n",
      "<Leader>dcb",
      '<cmd>lua require("dap").list_breakpoints()<cr>',
      { desc = "DAP: List Breakpoints" }
    )
    vim.keymap.set("n", "<Leader>dct", '<cmd>lua require("dap").terminate()<cr>', { desc = "DAP: Terminate" })
  end,
}
