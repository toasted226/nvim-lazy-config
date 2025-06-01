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

		-- HTML LSP
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.lsp.config('html', {
			capabilities = capabilities,
			cmp = { "vscode-html-language-server", "--stdio" },
			filetypes = { "html", "templ" },
			init_options = {
				configurationSection = { "html", "css", "javascript" },
				embeddedLanguages = {
					css = true,
					javascript = true
				},
				provideFormatter = true
			},
			root_markers = { "package.json", ".git" },
			settings = {},
		})
		vim.lsp.enable("html")

		-- Typescript LSP
		vim.lsp.config("ts_ls", {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			init_options = {
				hostInfo = "neovim"
			},
			root_markers = {
				"tsconfig.json",
				"jsconfig.json",
				"package.json",
				".git",
			},
		})
		vim.lsp.enable("ts_ls")

		-- ESLint
		local base_on_attach = vim.lsp.config.eslint.on_attach
		vim.lsp.config("eslint", {
			cmd = { "vscode-eslint-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"vue",
				"svelte",
				"astro"
			},
			on_attach = function(client, bufnr)
				if not base_on_attach then return end
				
				base_on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "LspEslintFixAll",
				})
			end,
		})
		vim.lsp.enable("eslint")

		-- Zig LSP
		require('lspconfig').zls.setup{}

		-- Nix LSP
		require('lspconfig').nixd.setup({})

		-- LaTeX LSP
		require('lspconfig').texlab.setup({
			settings = {
				texlab = {
					build = {
						executable = "latexmk",
						args = { "-pdf", "-pvc", "%f" },
						onSave = true,
					}
				}
			}
		})

		require('lspconfig').clangd.setup{}

		require('lspconfig').clojure_lsp.setup({})

		require('lspconfig').tailwindcss.setup({
			settings = {
				tailwindCSS = {
					classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
					experimental = {
						classRegex = { 
							{ "class: \"(.*)\"" }
						}
					},
					includeLanguages = {
						eelixir = "html-eex",
						eruby = "erb",
						htmlangular = "html",
						templ = "html",
						rust = "html"
					},
					lint = {
						cssConflict = "warning",
						invalidApply = "error",
						invalidConfigPath = "error",
						invalidScreen = "error",
						invalidTailwindDirective = "error",
						invalidVariant = "error",
						recommendedVariantOrder = "warning"
					},
					validate = true
				},
			},
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ", "rust" }
		})
	end,
	
}







