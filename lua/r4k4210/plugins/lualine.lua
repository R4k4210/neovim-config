return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- Color table for highlights
    -- stylua: ignore
    local colors = {
      bg       = '#202328',
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#51afef',
      red      = '#ec5f67',
    }

    -- Avante-specific color scheme
    local avante_colors = {
      bg = "#1a1a2e",
      fg = "#eee6e6",
      yellow = "#ffd700",
      cyan = "#40e0d0",
      darkblue = "#16213e",
      green = "#00ff7f",
      orange = "#ff6347",
      violet = "#dda0dd",
      magenta = "#ff1493",
      blue = "#4169e1",
      red = "#ff4500",
    }

    -- Function to get current color scheme based on filetype
    local function get_colors()
      if vim.bo.filetype == "Avante" or vim.bo.filetype == "AvanteInput" then
        return avante_colors
      else
        return colors
      end
    end

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
      -- Condición específica para ocultar lualine solo en buffers de Avante
      not_avante_buffer = function()
        return vim.bo.filetype ~= "Avante"
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
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = {
            c = function()
              local current_colors = get_colors()
              return { fg = current_colors.fg, bg = current_colors.bg }
            end,
          },
          inactive = {
            c = function()
              local current_colors = get_colors()
              return { fg = current_colors.fg, bg = current_colors.bg }
            end,
          },
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
                return { fg = "#6c7086" } -- Gray for not loaded
              end

              local status = vim.g.mcphub_status or "stopped"
              if status == "ready" or status == "restarted" then
                return { fg = "#50fa7b" } -- Green for connected
              elseif status == "starting" or status == "restarting" then
                return { fg = "#ffb86c" } -- Orange for connecting
              else
                return { fg = "#ff5555" } -- Red for error/stopped
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
      color = function()
        local current_colors = get_colors()
        return { fg = current_colors.blue }
      end,
      padding = { left = 0, right = 1 }, -- We don't need space before this
    })

    ins_left({
      -- mode component
      function()
        return ""
      end,
      color = function()
        local current_colors = get_colors()
        -- auto change color according to neovims mode
        local mode_color = {
          n = current_colors.red,
          i = current_colors.green,
          v = current_colors.blue,
          [""] = current_colors.blue,
          V = current_colors.blue,
          c = current_colors.magenta,
          no = current_colors.red,
          s = current_colors.orange,
          S = current_colors.orange,
          ["\19"] = current_colors.orange,
          ic = current_colors.yellow,
          R = current_colors.violet,
          Rv = current_colors.violet,
          cv = current_colors.red,
          ce = current_colors.red,
          r = current_colors.cyan,
          rm = current_colors.cyan,
          ["r?"] = current_colors.cyan,
          ["!"] = current_colors.red,
          t = current_colors.red,
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
          return { fg = "#E06C75", gui = "bold" } -- Rojo para Avante
        elseif vim.bo.filetype == "AvanteInput" then
          return { fg = "#98C379", gui = "bold" } -- Verde para AvanteInput
        else
          return { fg = colors.magenta, gui = "bold" } -- Color por defecto
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
      color = function()
        local current_colors = get_colors()
        return { fg = current_colors.cyan, gui = "bold" }
      end,
    })

    ins_left({
      -- Readonly indicator - only shows for readonly files
      function()
        if vim.bo.readonly then
          return "🔒"
        end
        return ""
      end,
      color = function()
        local current_colors = get_colors()
        return { fg = current_colors.red, gui = "bold" }
      end,
    })

    ins_left({ "location" })

    ins_left({
      "progress",
      color = function()
        local current_colors = get_colors()
        return { fg = current_colors.fg, gui = "bold" }
      end,
    })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = function()
          local current_colors = get_colors()
          return { fg = current_colors.red }
        end,
        color_warn = function()
          local current_colors = get_colors()
          return { fg = current_colors.yellow }
        end,
        color_info = function()
          local current_colors = get_colors()
          return { fg = current_colors.cyan }
        end,
      },
    })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    ins_left({
      -- Lsp server name .
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
      icon = " LSP:",
      color = { fg = "#ffffff", gui = "bold" },
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
      color = function()
        local current_colors = get_colors()
        return { fg = current_colors.red, gui = "bold" }
      end,
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
      -- Indentation info - shows current indentation settings
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
      "o:encoding", -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      "fileformat",
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      "branch",
      icon = "",
      color = { fg = colors.violet, gui = "bold" },
    })

    ins_right({
      "diff",
      -- Is it me or the symbol for modified us really weird
      symbols = { added = " ", modified = "󰝤 ", removed = " " },
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
      color = function()
        local current_colors = get_colors()
        return { fg = current_colors.blue }
      end,
      padding = { left = 1 },
    })
    -- configure lualine with modified theme
    lualine.setup(config)
  end,
}
