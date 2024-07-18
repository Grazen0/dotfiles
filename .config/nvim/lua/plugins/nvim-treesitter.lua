return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	opts = {
		auto_install = true,
		indent = { enable = true },
		highlight = { enable = true },
		autotag = { enable = true, enable_close_on_slash = false },
	},
	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end,
}
