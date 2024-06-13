return {
	'kyazdani42/nvim-tree.lua',
	config = function()
		require('nvim-tree').setup({
			view = {
				width = 30,
				side = 'left'
			},
			renderer = {
				group_empty = true,
			},
			-- filters = { enable = false },
			update_focused_file = {
				enable = true,
			},
			-- actions = { open_file = { quit_on_open = true } },
			renderer = {
				indent_markers = {
					enable = true,
				},
			},
		})

		local opts = { noremap = true, silent = true }

		vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<cr>', opts)
	end,
}
