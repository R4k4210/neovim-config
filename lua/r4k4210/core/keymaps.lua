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
