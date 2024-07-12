return {
	'kyazdani42/nvim-tree.lua',
	opts = {

		view = {
			width = 30,
			side = 'left',
		},
		filters = {
			custom = { '^.git$' },
			git_ignored = false,
		},
		update_focused_file = {
			enable = true,
		},
		-- actions = { open_file = { quit_on_open = true } },
		renderer = {
			highlight_git = 'name',
			indent_markers = {
				enable = true,
			},
			icons = {
				show = {
					folder_arrow = false,
				},
			},
		},
	},
	config = function(_, opts)
		require('nvim-tree').setup(opts)

		local key_opts = { noremap = true, silent = true }

		vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<cr>', key_opts)
	end,
}
