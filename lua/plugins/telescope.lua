return {
	{
		"nvim-telescope/telescope.nvim", tag = "0.1.8",
		dependencies = { 
			"nvim-lua/plenary.nvim", 
			"BurntSushi/ripgrep", 
			"nvim-tree/nvim-web-devicons"
		},

		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})



			-- keymaps for telescope
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope old files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
		end,
	}
}

