return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<leader>c", function()
			local bufdelete = require("bufdelete")
			bufdelete.bufdelete(0, true)
		end, { desc = "Close buffer", silent = true })
	end,
}
