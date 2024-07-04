return {
	'rebelot/kanagawa.nvim',
	opts = {
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		compile = true,
		transparent = false,
		keywordStyle = { italic = false },
		functionStyle = { italic = false },
		overrides = function(colors)
			local theme = colors.theme

			return {
				TelescopeTitle = { fg = theme.ui.special, bold = true },

				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
			}
		end,
	},
	config = function(_, opts)
		require('kanagawa').setup(opts)

		vim.cmd('colorscheme kanagawa')
		-- vim.cmd('highlight TelescopeBorder guibg=none')
		-- vim.cmd('highlight TelescopeTitle guibg=none')
	end,
}
