return {
	"andweeb/presence.nvim",

	config = function()
		require("presence").setup({
			-- General options
			neovim_image_text = "The One True Text Editor",
			buttons = false,
			enable_line_number = false,

			-- Rich Presence text options
			editing_text = "Editing %s",
			file_explorer_text = "Looking through %s",
			plugin_manager_text = "Fighting with vim plugins",
			workspace_text = "Hacking away at %s",
			line_number_text = "Line %s of %s",
		})
	end,
}
