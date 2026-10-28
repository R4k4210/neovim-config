-- Terminal of the sidekick window under the cursor, or the first open one.
local function current_terminal()
  local Terminal = require("sidekick.cli.terminal")
  local id = vim.w.sidekick_session_id
  if id and Terminal.get(id) then
    return Terminal.get(id)
  end
  for _, t in pairs(Terminal.terminals) do
    if t:is_open() then
      return t
    end
  end
  vim.notify("No open Sidekick CLI window", vim.log.levels.WARN, { title = "Sidekick" })
end

-- Switch between the configured split and a float covering the editor.
-- Reopening the window (instead of <C-w>|) makes the CLI re-render at the new size.
local function toggle_fullscreen(t)
  t = t or current_terminal()
  if not t then
    return
  end
  if t.opts.layout == "float" then
    t.opts.layout = t.split_layout or "bottom"
  else
    t.split_layout = t.opts.layout
    t.opts.layout = "float"
    t.opts.float = {
      row = 0,
      col = 0,
      width = vim.o.columns,
      height = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus > 0 and 1 or 0),
      border = "none",
    }
  end
  t:hide()
  t:focus()
end

-- Grow or shrink the split. The new height is kept while Neovim is open.
local function resize_height(t, delta)
  t = t or current_terminal()
  if not t or not t:is_open() or t.opts.layout == "float" then
    return
  end
  local height = math.max(5, vim.api.nvim_win_get_height(t.win) + delta)
  vim.api.nvim_win_set_height(t.win, height)
  t.opts.split.height = height
end

return {
  "folke/sidekick.nvim",
  opts = {
    -- NES (Next Edit Suggestions) needs a Copilot subscription. Only the AI
    -- CLI terminal is used here (Claude Code, Gemini CLI, ...).
    nes = { enabled = false },
    cli = {
      win = {
        layout = "bottom",
        split = { height = 45 },
        keys = {
          -- Same shortcut as toggleterm to leave terminal mode. Esc goes to the CLI.
          stopinsert_jk = { "jk", "stopinsert", mode = "t", desc = "enter normal mode" },
          fullscreen = { "<M-z>", toggle_fullscreen, mode = "nt", desc = "toggle fullscreen" },
          grow = {
            "<M-=>",
            function(t)
              resize_height(t, 5)
            end,
            mode = "nt",
            desc = "increase height",
          },
          shrink = {
            "<M-->",
            function(t)
              resize_height(t, -5)
            end,
            mode = "nt",
            desc = "decrease height",
          },
        },
      },
      tools = {
        -- Fullscreen TUI keeps no scrollback in the Neovim terminal buffer,
        -- so normal mode cannot scroll or yank. Use the classic renderer here.
        claude = {
          cmd = { "claude", "--settings", '{"tui":"default"}' },
        },
      },
    },
  },
  config = function(_, opts)
    -- Work profile (same as the `claude-work` shell alias). Custom tools get no
    -- defaults from `sk/cli/`, so reuse the bundled claude spec (format, resume, ...).
    local spec = dofile(vim.api.nvim_get_runtime_file("sk/cli/claude.lua", false)[1])
    opts.cli.tools.claude_work = vim.tbl_deep_extend("force", spec, opts.cli.tools.claude, {
      env = { CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude-work") },
    })
    require("sidekick").setup(opts)
  end,
  keys = {
    {
      "<C-,>",
      function()
        require("sidekick.cli").toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle AI CLI",
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Toggle AI CLI",
    },
    {
      "<leader>az",
      function()
        toggle_fullscreen()
      end,
      desc = "Toggle AI CLI fullscreen",
    },
    {
      "<leader>a=",
      function()
        resize_height(nil, 5)
      end,
      desc = "Increase AI CLI height",
    },
    {
      "<leader>a-",
      function()
        resize_height(nil, -5)
      end,
      desc = "Decrease AI CLI height",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      desc = "Select AI CLI",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "n", "x" },
      desc = "Send this",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send file",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = "x",
      desc = "Send selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Select prompt",
    },
  },
}
