-- crew.nvim: local development copy, loaded straight from disk.
-- Once published, replace `dir` and `name` with "R4k4210/crew.nvim".

-- The fullscreen TUI keeps no scrollback in a Neovim terminal buffer, so
-- normal mode could not scroll or yank. Use the classic renderer instead.
local claude = { "claude", "--settings", '{"tui":"default"}' }

return {
  dir = "~/_dev/_personal/crew.nvim",
  name = "crew.nvim",
  lazy = false,
  opts = {
    keys = {
      stopinsert = "jk", -- same as toggleterm
    },
    agents = {
      claude = { cmd = claude },
      ["claude-work"] = {
        cmd = claude,
        env = { CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude-work") },
      },
    },
  },
  keys = {
    -- Normal mode only: in an agent terminal Space must reach the agent.
    { "<leader>aa", "<cmd>Crew toggle<cr>", desc = "crew: editor <-> last agent" },
  },
}
