return {
  "github/copilot.vim",
  config = function()
    -- vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap("i", "<C-s>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
