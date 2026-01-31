return {
  -- Toggleterm: Better terminal integration
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Terminal configuration
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]], -- Default toggle keymap
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,

      -- Float terminal configuration
      float_opts = {
        border = "rounded", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 3,
        zindex = 100,
      },

      -- Window title
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end,
      },
    })

    -- Terminal keymaps
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Numbered floating terminals (for multi-project workflow)
    keymap("n", "<leader>t1", "<cmd>1ToggleTerm direction=float<cr>", vim.tbl_extend("force", opts, { desc = "Terminal 1" }))
    keymap("n", "<leader>t2", "<cmd>2ToggleTerm direction=float<cr>", vim.tbl_extend("force", opts, { desc = "Terminal 2" }))
    keymap("n", "<leader>t3", "<cmd>3ToggleTerm direction=float<cr>", vim.tbl_extend("force", opts, { desc = "Terminal 3" }))

    -- Terminal selector
    keymap("n", "<leader>tt", "<cmd>TermSelect<cr>", vim.tbl_extend("force", opts, { desc = "Select terminal" }))

    -- Direction variants
    keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", vim.tbl_extend("force", opts, { desc = "Horizontal terminal" }))
    keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", vim.tbl_extend("force", opts, { desc = "Vertical terminal" }))

    -- Specialized terminals
    keymap("n", "<leader>td", function()
      require("toggleterm.terminal").Terminal
        :new({
          cmd = "lazydocker",
          direction = "float",
          hidden = true,
        })
        :toggle()
    end, vim.tbl_extend("force", opts, { desc = "Lazydocker" }))

    -- Terminal mode keymaps (only essential ones to avoid Which-key conflicts)
    keymap("t", "<esc>", [[<C-\><C-n>]], opts)
    keymap("t", "jk", [[<C-\><C-n>]], opts)
  end,
}
