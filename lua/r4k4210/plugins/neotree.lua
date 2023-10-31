return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		local neotree = require("neo-tree")

		neotree.setup({
			window = {
				position = "right",
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				hijack_netrw_behavior = "open_current",
				se_libuv_file_watcher = true,
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.o.showmode = false
						vim.o.ruler = false
						vim.o.laststatus = 0
						vim.o.showcmd = false
					end,
				},
				{
					event = "neo_tree_buffer_leave",
					handler = function()
						vim.o.showmode = true
						vim.o.ruler = true
						vim.o.laststatus = 2
						vim.o.showcmd = true
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
	end,
}
