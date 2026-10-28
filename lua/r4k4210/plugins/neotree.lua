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
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.o.showmode = false
            vim.o.ruler = false
            -- visibility is handlded by lualine
            -- vim.o.laststatus = 0
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
            -- visibility is handlded by lualine
            -- vim.o.laststatus = 2
            vim.o.showcmd = true
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
  end,
}
