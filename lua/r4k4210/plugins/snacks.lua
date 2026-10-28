local dashboard = require("r4k4210.plugins.snacks.dashboard")
local layout = require("r4k4210.plugins.snacks.layout")("vertical")
local keymaps = require("r4k4210.plugins.snacks.keymaps")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        bigfile = { enabled = true },
        dashboard = dashboard,
        picker = {
          layout = layout,
          enabled = true,
          ui_select = false, -- vim.ui.select se define en init, con la altura corregida
          actions = require("trouble.sources.snacks").actions, -- integración con trouble
          hidden = true,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
          sources = {
            explorer = {
              layout = { layout = { position = "right" } },
            },
          },
        },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
          enabled = true,
          timeout = 3000,
          filter = function(msg, level, opts)
            local ft = vim.bo.filetype or ""

            if string.find(ft, "^Avante") then
              return false
            end

            return true
          end,
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          notification = {
            -- wo = { wrap = true }
          },
        },
      })
    end,
    keys = keymaps,
    init = function()
      -- snacks calcula la altura de la lista como `vim.o.lines * 0.8 - 10`, que con listas
      -- largas da un número no entero y nvim_win_set_config lo rechaza (E5108)
      vim.ui.select = function(items, opts, on_choice)
        opts = vim.tbl_extend("force", {}, opts or {})
        opts.snacks = Snacks.config.merge({}, opts.snacks or {}, {
          layout = {
            config = function(layout)
              for _, box in ipairs(layout.layout) do
                if box.win == "list" and not box.height then
                  box.height = math.max(math.min(#items, math.floor(vim.o.lines * 0.8 - 10)), 2)
                end
              end
            end,
          },
        })
        return Snacks.picker.select(items, opts, on_choice)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd

          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },

  -- TODO Comments: integración con Snacks
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  -- Trouble.nvim: solo carga comandos si se usa
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {},
  },
}
