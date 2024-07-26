return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	opts = {
		auto_install = true,
		ignore_install = { 'latex' },
		indent = { enable = true },
		highlight = { enable = true },
		autotag = { enable = true, enable_close_on_slash = false },
	},
	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)

		vim.filetype.add({
			pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
		})
	end,
}
