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

vim.keymap.set('n', '<leader>ee', ':Ex <CR>', { desc = 'Explore' })
vim.keymap.set('n', '<leader>t', ':terminal <CR>', { desc = 'Terminal' })

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
})

vim.cmd([[colorscheme monokai-pro]])

vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NonText guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight LineNr guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])

vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.g.airline_powerline_fonts = 1
