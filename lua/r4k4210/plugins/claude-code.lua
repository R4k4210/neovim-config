return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claude-code").setup({
      window = {
        position = "float",
        float = {
          width = "90%",
          height = "90%",
          row = "center",
          col = "center",
          relative = "editor",
          border = "rounded",
        },
      },
      keymaps = {
        toggle = {
          -- <C-,> handles both opening (normal mode) and closing (terminal
          -- mode). The plugin only accepts ONE binding per mode, so the
          -- additional <leader>Cc binding is added below outside setup().
          normal = "<C-,>",
          terminal = "<C-,>",
          variants = {
            continue = "<leader>CC",
            resume = "<leader>Cr",
            verbose = "<leader>CV",
          },
        },
        window_navigation = true,
        scrolling = true,
      },
    })

    -- Secondary toggle under the <leader>C (Claude Code) namespace. Moved
    -- off <leader>ac (= AvanteClear) and off <leader>c* (= Colors & Rename).
    vim.keymap.set("n", "<leader>Cc", "<cmd>ClaudeCode<CR>",
      { desc = "Toggle Claude Code" })
  end,
}
