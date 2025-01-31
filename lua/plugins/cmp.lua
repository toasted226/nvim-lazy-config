return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
	},
	event = {"BufReadPre", "BufNewFile"},


	config = function()
		-- cmp config
		local cmp = require'cmp'

    	cmp.setup({
    		snippet = {
    			expand = function(args)
    				vim.fn["vsnip#anonymous"](args.body)
    			end,
    		},
    		window = {
    			completion = cmp.config.window.bordered(),
    			documentation = cmp.config.window.bordered(),
    		},
    		mapping = cmp.mapping.preset.insert({
    			['<C-b>'] = cmp.mapping.scroll_docs(-4),
    			['<C-f>'] = cmp.mapping.scroll_docs(4),
    			['<C-Space>'] = cmp.mapping.complete(),
    			['<C-e>'] = cmp.mapping.abort(),
    			['<C-n>'] = cmp.mapping.select_next_item(),
    			['<C-p>'] = cmp.mapping.select_prev_item(),
    			['<CR>'] = cmp.mapping.confirm({ select = true }),
    			['<Tab>'] = cmp.mapping.confirm({ select = true }),
    		}),
    		sources = cmp.config.sources({
    			{ name = 'nvim_lsp' },
    			{ name = 'vsnip' },
    		}, {
    			{ name = 'buffer' }	
    		})
    	})

    	cmp.setup.cmdline({ '/', '?' }, {
    		mapping = cmp.mapping.preset.cmdline(),
    		sources = {
    			{ name = 'buffer' }
    		}
    	})

    	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    	cmp.setup.cmdline(':', {
    		mapping = cmp.mapping.preset.cmdline(),
    		sources = cmp.config.sources({
    			{ name = 'path' }
    		}, {
    			{ name = 'cmdline' }
    		}),
    		matching = { disallow_symbol_nonprefix_matching = false }
    	})

		-- LSP config

		-- Reserve a space in the gutter
		-- This will avoid an annoying layout shift in the screen
		vim.opt.signcolumn = 'yes'

		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		-- This should be executed before you configure any language server
    	local lspconfig_defaults = require('lspconfig').util.default_config
    	lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    	  'force',
    	  lspconfig_defaults.capabilities,
    	  require('cmp_nvim_lsp').default_capabilities()
    	)

		-- This is where you enable features that only work
		-- if there is a language server active in the file
    	vim.api.nvim_create_autocmd('LspAttach', {
    	  desc = 'LSP actions',
    	  callback = function(event)
    		local opts = {buffer = event.buf}

    		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    		vim.keymap.set('n', '<leader>pf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    	  end,
    	})

		vim.opt.completeopt = {"menu", "menuone", "noselect"}

		-- Go LSP
		require('lspconfig').gopls.setup({})

		-- Rust LSP
		require('lspconfig').rust_analyzer.setup({
			settings = {
				['rust-analyzer'] = {
					diagnostics = {
						enable = false;
					}
				}
			}
		})

		-- Zig LSP
		require('lspconfig').zls.setup{}

		-- Nix LSP
		require('lspconfig').nixd.setup({})
	end,
	
}







