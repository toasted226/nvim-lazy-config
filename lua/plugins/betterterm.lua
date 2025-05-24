return {
	"CRAG666/betterTerm.nvim",

	keys = {
		{
			mode = { 'n', 't' },
			'<leader>t',
			function()
			require('betterTerm').open(0)
			end,
			desc = 'Open BetterTerm 0',
		},
		{
			'<leader>ft',
			function()
				require('betterTerm').select()
			end,
			desc = 'Select terminal',
		}
	},
	opts = {
		prefix = "term-",
		position = 'bot',
		size = 15,
		jump_tab_mapping = "<leader>$tab",
		new_tab_mapping = "<C-t>",
		active_tab_hl = "TabLineSel",
		inactive_tab_hl = "TabLine",
		new_tab_hl = "BetterTermSymbol",
		new_tab_icon = "+"
	},
}
