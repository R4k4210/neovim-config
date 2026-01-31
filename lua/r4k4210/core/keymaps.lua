-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- hide highlights on escape
keymap.set("n", "<Esc>", "<cmd>noh<CR>", { silent = true, noremap = true })

-- close
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>w", ":w!<CR>", { desc = "Save buffer forced" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- move on input mode
keymap.set("i", "<M-h>", "<Left>")
keymap.set("i", "<M-j>", "<Down>")
keymap.set("i", "<M-k>", "<Up>")
keymap.set("i", "<M-l>", "<Right>")

keymap.set("n", "dw", "dvb", { desc = "Delete word backwards" })

-- Bufferline
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
keymap.set(
  "n",
  "<leader>be",
  "<cmd>BufferLineSortByExtension<CR>",
  { desc = "Buffer sort by extension", silent = true }
)
keymap.set(
  "n",
  "<leader>bd",
  "<cmd>BufferLineSortByDirectory<CR>",
  { desc = "Buffer sort by directory", silent = true }
)
keymap.set("n", "<leader>b>", "<cmd>BufferLineMoveNext<CR>", { desc = "Buffer move next", silent = true })
keymap.set("n", "<leader>b<", "<cmd>BufferLineMovePrev<CR>", { desc = "Buffer move prev", silent = true })

-- Move code
keymap.set("n", "<M-Up>", "<cmd>m .-2<CR>", { desc = "move line up" })
keymap.set("n", "<M-Down>", "<cmd>m .+1<CR>", { desc = "move line down" })

-- Avante AI
keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Ask" })
keymap.set("v", "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Ask with selection" })
keymap.set("n", "<leader>at", "<cmd>AvanteToggle<CR>", { desc = "Toggle sidebar" })
keymap.set("n", "<leader>ar", "<cmd>AvanteRefresh<CR>", { desc = "Refresh" })
keymap.set("n", "<leader>ae", "<cmd>AvanteEdit<CR>", { desc = "Edit" })
keymap.set("v", "<leader>ae", "<cmd>AvanteEdit<CR>", { desc = "Edit selection" })
keymap.set("n", "<leader>ac", "<cmd>AvanteClear<CR>", { desc = "Clear chat" })
keymap.set("n", "<leader>af", "<cmd>AvanteFocus<CR>", { desc = "Focus input" })
keymap.set("n", "<leader>as", "<cmd>AvanteStop<CR>", { desc = "Stop generation" })

-- Avante: Switch provider (with snacks selector)
keymap.set("n", "<leader>ap", function()
  local providers = {
    "claude-code",        -- ACP: Full agentic Claude Code
    "openrouter-gpt5",    -- API: GPT-5 via OpenRouter
    "claudio-sonnet-4.5", -- API: Claude Sonnet via OpenRouter
    "claudio-opus-4.5",   -- API: Claude Opus via OpenRouter
  }
  vim.ui.select(providers, {
    prompt = "Select Avante Provider:",
    format_item = function(item)
      if item == "claude-code" then
        return item .. " (ACP - Agentic)"
      else
        return item .. " (API)"
      end
    end,
  }, function(choice)
    if choice then
      require("avante.api").switch_provider(choice)
      vim.notify("Avante provider: " .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = "Switch provider" })
