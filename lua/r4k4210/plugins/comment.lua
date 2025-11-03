return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- enable comment with built-in treesitter integration
		require("Comment").setup()
	end,
}
