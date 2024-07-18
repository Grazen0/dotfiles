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

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.25

return {
	'kyazdani42/nvim-tree.lua',
	config = function(_, opts)
		require('nvim-tree').setup(opts)

		vim.api.nvim_set_keymap(
			'n',
			'<leader>tt',
			'<cmd>NvimTreeToggle<CR>',
			{ silent = true, noremap = true }
		)
	end,
	lazy = false,
	opts = {
		hijack_directories = {
			enable = false,
		},
		view = {
			relativenumber = true,
			float = {
				enable = true,
				open_win_config = function()
					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get()
						- vim.opt.cmdheight:get()
					local window_w = screen_w * WIDTH_RATIO
					local window_h = screen_h * HEIGHT_RATIO
					local window_w_int = math.floor(window_w)
					local window_h_int = math.floor(window_h)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2)
						- vim.opt.cmdheight:get()
					return {
						relative = 'editor',
						row = center_y,
						col = center_x,
						width = window_w_int,
						height = window_h_int,
					}
				end,
			},
			width = {
				min = 40,
			},
		},
		filters = {
			custom = { '^.git$' },
			git_ignored = false,
		},
		update_focused_file = {
			enable = true,
		},
		hijack_cursor = true,
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
