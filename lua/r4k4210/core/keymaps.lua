-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- hide highlights on escape
keymap.set("n", "<Esc>", "<cmd>noh<CR>", { silent = true, noremap = true })

-- close
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>w", ":w!<CR>", { desc = "Save buffer forced" })

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

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

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<C-S-Left>", ":vertical resize +5<CR>", { silent = true, noremap = true })
keymap.set("n", "<C-S-Right>", ":vertical resize -5<CR>", { silent = true, noremap = true })
keymap.set("n", "<C-S-Right>", ":resize +5<CR>", { silent = true, noremap = true })
keymap.set("n", "<C-S-Left>", ":resize -5<CR>", { silent = true, noremap = true })

keymap.set("n", "dw", "dvb", { desc = "Delete word backwards" })

-- Lazydocker
keymap.set("n", "<leader>md", function()
  require("toggleterm.terminal").Terminal
    :new({
      cmd = "lazydocker",
      direction = "float",
      hidden = true,
    })
    :toggle()
end, { desc = "Lazydocker" })

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

-- Diffview // overrides default diff
keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "DiffviewOpen" })
keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { desc = "DiffviewClose" })

-- Lazygit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open Lazygit" })

-- Gitsigns
keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Git stage hunk" })
keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })
keymap.set("n", "<leader>gf", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Git stage buffer" })
keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Git reset buffer" })
keymap.set("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Git undo stage hunk" })
keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })
keymap.set("n", "<leader>gb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", { desc = "Git blame full" })
keymap.set("n", "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Git blame line" })

-- Rename inc-rename
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })
