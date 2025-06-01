-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.wo.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set('n', '<leader>fe', ':Ex <CR>', { desc = 'Explore' })
-- vim.keymap.set('n', '<leader>t', ':terminal <CR>', { desc = 'Terminal' })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "monokai-pro" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("monokai-pro").setup({
	filter = "pro",
	transparent = true,
})

vim.cmd([[colorscheme monokai-pro]])

vim.g.clipboard = {
	name = "wl-clipboard",
	copy = {
		["+"] = "wl-copy",
		["*"] = "wl-copy",
	},
	paste = {
		["+"] = "wl-paste",
		["*"] = "wl-paste",
	},
	cache_enabled = true,
}

--vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.cmd [[
	" General UI
	highlight! Normal guibg=none ctermbg=none
	highlight! NormalNC guibg=none ctermbg=none
	highlight! FloatBorder guibg=NONE ctermbg=NONE
	highlight! NormalFloat guibg=NONE ctermbg=NONE
	highlight! NonText guibg=none ctermbg=none
	highlight! LineNr ctermbg=none guibg=none
	highlight! SignColumn ctermbg=none guibg=none
	highlight! Keyword ctermbg=none guibg=none
	highlight! String ctermbg=none guibg=none
	highlight! LspReferenceText ctermbg=none guibg=none
	highlight! IlluminatedWordText ctermbg=none  guibg=none

	" LSP hover and signature help windows
	highlight! LspInfoBorder guibg=NONE ctermbg=NONE
	highlight! LspFloatWinBorder guibg=NONE ctermbg=NONE
	highlight! LspReferenceRead ctermbg=none guibg=none
	highlight! IlluminatedWordRead ctermbg=none guibg=none

	highlight! LspReferenceWrite ctermbg=none guibg=none
	highlight! IlluminatedWordRead ctermbg=none guibg=none

	" Completion menu and borders
	highlight! PmenuBorder guibg=NONE ctermbg=NONE

	" For nvim-cmp users
	highlight! CmpBorder guibg=NONE ctermbg=NONE
	highlight! CmpDocBorder guibg=NONE ctermbg=NONE

	highlight! BufferLineBackground guibg=none ctermbg=none
	highlight! EndOfBuffer guibg=none ctermbg=none

	highlight! TelescopeNormal guibg=none ctermbg=none
	highlight! TelescopePromptNormal guibg=NONE ctermbg=NONE
	highlight! TelescopeResultsNormal guibg=NONE ctermbg=NONE
	highlight! TelescopePreviewNormal guibg=NONE ctermbg=NONE
	highlight! TelescopePromptBorder guibg=NONE ctermbg=NONE
	highlight! TelescopeResultsBorder guibg=NONE ctermbg=NONE
	highlight! TelescopePreviewBorder guibg=NONE ctermbg=NONE
]]

--	highlight! Pmenu guibg=NONE ctermbg=NONE
--	highlight! CmpPmenu guibg=NONE ctermbg=NONE
--	highlight! CmpPmenuSel guibg=NONE ctermbg=NONE
--	highlight! PmenuSel guibg=NONE ctermbg=NONE
