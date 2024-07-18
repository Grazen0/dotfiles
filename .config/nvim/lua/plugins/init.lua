return {
	'mg979/vim-visual-multi',
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'andweeb/presence.nvim',
	'fladson/vim-kitty',
	'b0o/schemastore.nvim',
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = { 'williamboman/mason.nvim' },
		config = true,
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
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	{
		'iamcco/markdown-preview.nvim',
		cmd = {
			'MarkdownPreviewToggle',
			'MarkdownPreview',
			'MarkdownPreviewStop',
		},
		ft = { 'markdown' },
		build = function()
			vim.fn['mkdp#util#install']()
		end,
	},
	{
		'numToStr/Comment.nvim',
		config = true,
		lazy = false,
	},
}
