-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

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
keymap.set("n", "<leader>b<", "<cmd>BufferLineMoveNext<CR>", { desc = "Buffer move prev", silent = true })

-- Move code
keymap.set("n", "<M-k>", "<cmd>m .-2<CR>", { desc = "move line up" })
keymap.set("n", "<M-j>", "<cmd>m .+2<CR>", { desc = "move line down" })

-- Diffview // overrides default diff
keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "DiffviewOpen" })
keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { desc = "DiffviewClose" })

-- Lazygit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open Lazygit" })
