return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
		},
	},
	after = "catppuccin",
	config = function()
		local bufferline = require("bufferline")
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		bufferline.setup({
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "italic", "bold" },
				custom = {
					all = {
						fill = { bg = "#000000" },
					},
					mocha = {
						background = { fg = mocha.text },
					},
					latte = {
						background = { fg = "#000000" },
					},
				},
			}),
		})
	end,
}
