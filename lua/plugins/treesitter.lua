return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function () 
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "rust", "python", "typescript", "html", "javascript", "comment", "zig", "clojure", "fennel", "css", "bash", "tsx" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})
	end
}
