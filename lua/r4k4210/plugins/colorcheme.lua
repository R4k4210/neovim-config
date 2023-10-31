return {
	-- {
	-- 	"bluz71/vim-nightfly-guicolors",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local catppuccin = require("catppuccin")

			catppuccin.setup({
				flavour = "mocha",
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				integrations = {
					cmp = true,
					treesitter = true,
					neotree = false,
					notify = false,
					alpha = true,
					telescope = {
						enabled = true,
					},
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})

			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
