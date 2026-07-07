return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	-- Solo se carga cuando usás uno de estos comandos o atajos (arranque liviano)
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
	},
	keys = {
		-- Diff del working tree (lo que cambiaste vs el último commit).
		-- Si estás en medio de un merge con conflictos, abre directo la
		-- vista 3-way: OURS (izq) | resultado (centro) | THEIRS (der).
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "DiffView (abrir / conflictos)" },
		{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "DiffView (cerrar)" },
		-- Historial del archivo actual / de todo el repo
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView historial (archivo)" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView historial (repo)" },
	},
	opts = {
		enhanced_diff_hl = true, -- mejor resaltado de cambios dentro de la línea
		view = {
			-- Layout de la vista de conflictos: 3 paneles verticales
			merge_tool = {
				layout = "diff3_mixed", -- OURS | resultado | THEIRS
				disable_diagnostics = true,
			},
		},
		keymaps = {
			-- Atajos DENTRO de la vista de conflictos (modo normal):
			--   <leader>co  -> elegir OURS (tu versión local)
			--   <leader>ct  -> elegir THEIRS (la otra rama / origin)
			--   <leader>cb  -> elegir BASE
			--   <leader>ca  -> traer TODOS los lados
			--   ]x / [x     -> saltar al conflicto siguiente / anterior
			-- (vienen por defecto en diffview, los dejo documentados acá)
		},
	},
}
