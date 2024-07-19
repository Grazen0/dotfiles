local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
		return {
			desc = 'nvim-tree: ' .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	-- Open file on creation
	api.events.subscribe(api.events.Event.FileCreated, function(file)
		vim.cmd('edit ' .. file.fname)
	end)

	local function edit_or_open()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			api.node.open.edit()
		else
			api.node.open.edit()
			api.tree.close()
		end
	end

	local function vsplit_preview()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			api.node.open.edit()
		else
			api.node.open.vertical()
		end

		api.tree.focus()
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set('n', 'l', edit_or_open, opts('Edit Or Open'))
	vim.keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
	vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
	vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	'kyazdani42/nvim-tree.lua',
	lazy = false,
	config = function(_, opts)
		require('nvim-tree').setup(opts)

		vim.api.nvim_set_keymap(
			'n',
			'<leader>e',
			'<cmd>NvimTreeToggle<CR>',
			{ silent = true, noremap = true }
		)
	end,
	opts = {
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		view = {
			relativenumber = true,
		},
		filters = {
			custom = { '^.git$' },
			git_ignored = false,
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		hijack_cursor = true,
		hijack_netrw = false,
		actions = { open_file = { quit_on_open = true } },
		renderer = {
			highlight_git = 'name',
			icons = {
				show = {
					folder_arrow = false,
				},
			},
		},
		on_attach = my_on_attach,
	},
}
