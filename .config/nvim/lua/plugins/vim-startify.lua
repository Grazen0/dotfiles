local header = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                         Welcome back to                               ]],
	[[                                                                       ]],
	[[  ██████   █████                   █████   █████  ███                  ]],
	[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
	[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
	[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
	[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
	[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
	[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
	[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
	[[                                                                       ]],
}

function TableConcat(t1, t2)
	for i = 1, #t2 do
		t1[#t1 + 1] = t2[i]
	end
	return t1
end

return {
	'mhinz/vim-startify',
	config = function()
		vim.g.startify_custom_header = vim.fn['startify#center'](header)

		vim.g.startify_session_autoload = 1
		vim.g.startify_session_persistence = 1
		vim.g.startify_change_to_vcs_root = 1


		vim.cmd([[
		function! StartifyEntryFormat() abort
			return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
		endfunction
		]])

		function _G.webDevIcons(path)
			local filename = vim.fn.fnamemodify(path, ":t")
			local extension = vim.fn.fnamemodify(path, ":e")
			return require("nvim-web-devicons").get_icon(filename, extension, { default = true })
		end
	end,
}
