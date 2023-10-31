return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			-- "                                                     ",
			-- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			-- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			-- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			-- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			-- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			-- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			-- "                                                     ",
			[[                                                                     ]],
			[[       ███████████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      ████████████████ ███████████ ███   ███████     ]],
			[[     ████████████████ ████████████ █████ ██████████████   ]],
			[[    █████████████████████████████ █████ █████ ████ █████   ]],
			[[  ██████████████████████████████████ █████ █████ ████ █████  ]],
			[[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
			[[ ██████   ██  ███████████████   ██ █████████████████ ]],
			[[ ██████   ██  ███████████████   ██ █████████████████ ]],
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("LDR ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("LDR fs", " > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("LDR wr", "󰁯 > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("e", " > New File", "<cmd>ene<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
		dashboard.config.layout[3].val = 5
		dashboard.config.opts.noautocmd = true
		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
