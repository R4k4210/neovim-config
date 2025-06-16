return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local neotree = require("neo-tree")

    neotree.setup({
      window = {
        position = "right",
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        hijack_netrw_behavior = "open_current",
        se_libuv_file_watcher = true,
        commands = {
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require("avante.utils").relative_path(filepath)

            local sidebar = require("avante").get()

            local open = sidebar:is_open()
            -- ensure avante sidebar is open
            if not open then
              require("avante.api").ask()
              sidebar = require("avante").get()
            end

            sidebar.file_selector:add_selected_file(relative_path)

            -- remove neo tree buffer
            if not open then
              sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
            end
          end,
        },
        window = {
          mappings = {
            ["oa"] = "avante_add_files",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.o.showmode = false
            vim.o.ruler = false
            vim.o.laststatus = 0
            vim.o.showcmd = false

            -- 🧠 Autocierre si Neo-tree es el único buffer visible
            local visible_bufs = vim.fn.getbufinfo({ buflisted = 1 })
            if #visible_bufs == 1 and visible_bufs[1].name:match("neo%-tree filesystem") then
              vim.cmd("quit")
            end
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.o.showmode = true
            vim.o.ruler = true
            vim.o.laststatus = 2
            vim.o.showcmd = true
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
  end,
}
