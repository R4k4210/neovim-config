-- crew.nvim: local development copy, loaded straight from disk.
-- Once published, replace `dir` and `name` with "R4k4210/crew.nvim".

-- The fullscreen TUI keeps no scrollback in a Neovim terminal buffer, so
-- normal mode could not scroll or yank. Use the classic renderer instead.
local claude = { "claude", "--settings", '{"tui":"default"}' }

return {
  "R4k4210/crew.nvim",
  dev = true,
  lazy = false,
  opts = {
    keys = {
      stopinsert = "jk", -- same as toggleterm
    },
    agents = {
      -- statusline = false: inside crew only crew's header and pills show usage.
      claude = { cmd = claude, statusline = false },
      ["claude-work"] = {
        cmd = claude,
        statusline = false,
        env = { CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude-work") },
      },
      agy = { cmd = { "agy" }, statusline = false },
    },
  },
  keys = {
    -- Normal mode only: in an agent terminal Space must reach the agent.
    { "<leader>aa", "<cmd>Crew toggle<cr>", desc = "crew: editor <-> last agent" },
  },
}
