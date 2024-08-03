return {
	'mg979/vim-visual-multi',
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'andweeb/presence.nvim',
	'fladson/vim-kitty',
	'baskerville/vim-sxhkdrc',
	'b0o/schemastore.nvim',
	'DaikyXendo/nvim-material-icon',
	'airblade/vim-gitgutter',
	{
		'RRethy/vim-hexokinase',
		build = 'make hexokinase',
	},
	{
		'rmagatti/auto-session',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		opts = {
			auto_session_suppress_dirs = {
				'~/',
				'~/Code',
				'~/Downloads',
				'/',
			},
		},
		config = function(_, opts)
			require('auto-session').setup(opts)

			vim.o.sessionoptions =
			'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

			vim.keymap.set(
				'n',
				'<leader>fs',
				require('auto-session.session-lens').search_session,
				{ noremap = true }
			)
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
			'hrsh7th/nvim-cmp',
		},
		opts = {
			ensure_installed = {
				'html',
				'cssls',
				'lua_ls',
				'jsonls',
				'clangd',
				'pyright',
				'texlab',
				'tsserver',
				'rust_analyzer',
			},
		},
		config = function(_, opts)
			local m = require('mason-lspconfig')
			m.setup(opts)

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lsp_options = {
				jsonls = {
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {},
					},
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if
							vim.loop.fs_stat(path .. '/.luarc.json')
							or vim.loop.fs_stat(path .. '/.luarc.jsonc')
						then
							return
						end

						client.config.settings.Lua = vim.tbl_deep_extend(
							'force',
							client.config.settings.Lua,
							{
								runtime = {
									version = 'LuaJIT',
								},
								workspace = {
									checkThirdParty = false,
									library = { vim.env.VIMRUNTIME },
								},
							}
						)
					end,
				},
			}

			m.setup_handlers({
				function(server_name)
					if lsp_options[server_name] ~= nil then
						lsp_options[server_name].capabilities = capabilities
						require('lspconfig')[server_name].setup(
							lsp_options[server_name]
						)
					else
						require('lspconfig')[server_name].setup({ capabilities })
					end
				end,
			})
		end,
	},
	{
		'williamboman/mason.nvim',
		config = true,
		opts = {

			ui = {
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
		},
	},
	{
		'windwp/nvim-autopairs',
		config = true,
		event = 'InsertEnter',
	},
	{
		'KeitaNakamura/tex-conceal.vim',
		init = function()
			vim.g.tex_conceal = 'abdmg'
			vim.cmd('hi Conceal ctermbg=None')
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		config = true,
	},
	{
		'iamcco/markdown-preview.nvim',
		cmd = {
			'MarkdownPreviewToggle',
			'MarkdownPreview',
			'MarkdownPreviewStop',
		},
		build = 'cd app && pnpm install',
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { 'markdown' },
	},
	{
		'numToStr/Comment.nvim',
		config = true,
		lazy = false,
	},
}
