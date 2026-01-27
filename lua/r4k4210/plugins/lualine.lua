return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local c = require("r4k4210.core.colors")

    -- Color table for highlights (from centralized colors)
    local colors = c.lualine

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        -- Disable lualine for Avante chat windows and Neo-tree
        disabled_filetypes = {
          statusline = { "Avante", "AvanteInput", "neo-tree" },
          winbar = { "Avante", "AvanteInput", "neo-tree" },
        },
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {
          {
            function()
              -- Check if MCPHub is loaded
              if not vim.g.loaded_mcphub then
                return "󰐻 -"
              end

              local count = vim.g.mcphub_servers_count or 0
              local status = vim.g.mcphub_status or "stopped"
              local executing = vim.g.mcphub_executing

              -- Show "-" when stopped
              if status == "stopped" then
                return "󰐻 -"
              end

              -- Show spinner when executing, starting, or restarting
              if executing or status == "starting" or status == "restarting" then
                local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                local frame = math.floor(vim.uv.now() / 100) % #frames + 1
                return "󰐻 " .. frames[frame]
              end

              return "󰐻 " .. count
            end,
            color = function()
              if not vim.g.loaded_mcphub then
                return { fg = c.base.fg_dark } -- Gray for not loaded
              end

              local status = vim.g.mcphub_status or "stopped"
              if status == "ready" or status == "restarted" then
                return { fg = colors.green } -- Green for connected
              elseif status == "starting" or status == "restarting" then
                return { fg = colors.orange } -- Orange for connecting
              else
                return { fg = colors.red } -- Red for error/stopped
              end
            end,
          },
        },
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 0, right = 1 },
    })

    ins_left({
      -- mode component
      function()
        return ""
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          ["\19"] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    })

    ins_left({
      -- filesize component
      "filesize",
      cond = conditions.buffer_not_empty,
    })

    ins_left({
      "filename",
      cond = conditions.buffer_not_empty,
      color = function()
        -- Cambiar color según el filetype del buffer
        if vim.bo.filetype == "Avante" then
          return { fg = colors.red, gui = "bold" }
        elseif vim.bo.filetype == "AvanteInput" then
          return { fg = colors.green, gui = "bold" }
        else
          return { fg = colors.magenta, gui = "bold" }
        end
      end,
    })

    ins_left({
      -- Buffer counter - only shows if multiple buffers
      function()
        local buffers = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)"))
        if buffers > 1 then
          local current = vim.fn.bufnr("%")
          local buf_list = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)")
          local current_index = vim.fn.index(buf_list, current) + 1
          return "󰓩 " .. current_index .. "/" .. buffers
        end
        return ""
      end,
      color = { fg = colors.cyan, gui = "bold" },
    })

    ins_left({
      -- Readonly indicator - only shows for readonly files
      function()
        if vim.bo.readonly then
          return "🔒"
        end
        return ""
      end,
      color = { fg = colors.red, gui = "bold" },
    })

    ins_left({ "location" })

    ins_left({
      "progress",
      color = { fg = colors.fg, gui = "bold" },
    })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    -- Insert mid section
    ins_left({
      function()
        return "%="
      end,
    })

    ins_left({
      -- Lsp server name
      function()
        local msg = "No Active Lsp"
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          return client.name
        end
        return msg
      end,
      icon = " LSP:",
      color = { fg = c.base.fg_light, gui = "bold" },
    })

    -- Add components to right sections
    ins_right({
      -- Macro recording indicator
      function()
        local recording = vim.fn.reg_recording()
        if recording ~= "" then
          return "󰑊 " .. recording
        end
        return ""
      end,
      color = { fg = colors.red, gui = "bold" },
    })

    ins_right({
      -- Lazy.nvim updates indicator
      function()
        local lazy_status = require("lazy.status")
        if lazy_status.has_updates() then
          return "󰏗 " .. lazy_status.updates()
        end
        return ""
      end,
      color = { fg = colors.orange },
      cond = function()
        return require("lazy.status").has_updates()
      end,
    })

    ins_right({
      -- Indentation info
      function()
        local expandtab = vim.bo.expandtab
        local shiftwidth = vim.bo.shiftwidth
        if expandtab then
          return shiftwidth .. " spaces"
        else
          return "tabs"
        end
      end,
      cond = conditions.hide_in_width,
      color = { fg = colors.yellow, gui = "bold" },
    })

    ins_right({
      "o:encoding",
      fmt = string.upper,
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      "fileformat",
      fmt = string.upper,
      icons_enabled = false,
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      "branch",
      icon = "",
      color = { fg = colors.violet, gui = "bold" },
    })

    ins_right({
      "diff",
      symbols = { added = " ", modified = "󰝤 ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    ins_right({
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    })

    -- configure lualine with modified theme
    lualine.setup(config)
  end,
}
