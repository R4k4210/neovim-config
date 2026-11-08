return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  },
  init = function()
    -- A session that saves the Neo-tree window restores it as a plain buffer
    -- named "neo-tree filesystem [1]", which breaks the next <leader>e.
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceSavePre",
      desc = "Keep Neo-tree out of saved sessions",
      callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].filetype == "neo-tree" then
            pcall(vim.api.nvim_buf_delete, buf, { force = true })
          end
        end
      end,
    })
  end,
}
