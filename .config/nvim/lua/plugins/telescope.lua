return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local actions = require('telescope.actions')

		require('telescope').setup({
			pickers = {
				find_files = {
					hidden = true,
					file_ignore_patterns = {
						'.git/',
						'.cache',
						'%.o',
						'%.a',
						'%.out',
						'%.class',
						'%.pdf',
						'%.mkv',
						'%.mp4',
						'%.zip',
					},
				},
			},
			defaults = {
				mappings = {
					n = {
						['q'] = actions.close,
					},
					i = {
						['<C-u>'] = false,
					},
				},
			},
		})

		local builtin = require('telescope.builtin')

		local opts = {
			noremap = true,
		}

		vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
		vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
		vim.keymap.set('n', '<leader>fr', builtin.lsp_references, opts)
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
	end,
}
