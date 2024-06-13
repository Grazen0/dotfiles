local header = {
	[[                                                                    ]],
	[[                                                                    ]],
	[[                       Welcome back to                              ]],
	[[                                                                    ]],
	[[888b    888 8888888888  .d88888b.  888     888 8888888 888b     d888]],
	[[8888b   888 888        d88P" "Y88b 888     888   888   8888b   d8888]],
	[[88888b  888 888        888     888 888     888   888   88888b.d88888]],
	[[888Y88b 888 8888888    888     888 Y88b   d88P   888   888Y88888P888]],
	[[888 Y88b888 888        888     888  Y88b d88P    888   888 Y888P 888]],
	[[888  Y88888 888        888     888   Y88o88P     888   888  Y8P  888]],
	[[888   Y8888 888        Y88b. .d88P    Y888P      888   888   "   888]],
	[[888    Y888 8888888888  "Y88888P"      Y8P     8888888 888       888]],
	[[                                                                    ]],
	[[                                                                    ]],
}

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
