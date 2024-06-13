return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function(_, opts)
		local actions = require('telescope.actions')

		require('telescope').setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			defaults = {
				mappings = {
					i = {
						['<Esc>'] = actions.close,
					},
				},
			},
		})
		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	end,
}
