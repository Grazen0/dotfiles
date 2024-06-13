return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	opts = {
		ensure_installed = { 'c', 'cpp', 'lua', 'vimdoc', 'typescript', 'javascript', 'python' },
		indent = { enable = true },
		highlight = { enable = true },
	},
	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end,
}
