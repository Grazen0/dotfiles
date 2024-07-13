return {
	'rebelot/kanagawa.nvim',
	opts = {
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = 'none',
					},
				},
			},
		},
		transparent = true,
		keywordStyle = { italic = false },
		functionStyle = { italic = false },
		overrides = function(colors)
			local theme = colors.theme

			return {
				NormalFloat = { bg = 'none' },
				FloatBorder = { bg = 'none' },
				FloatTitle = { bg = 'none' },
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

				Pmenu = {
					fg = theme.ui.shade0,
					bg = theme.ui.bg_p1,
					blend = vim.o.pumblend,
				},
				PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
			}
		end,
	},
	config = function(_, opts)
		require('kanagawa').setup(opts)

		vim.cmd('colorscheme kanagawa')
		vim.cmd('highlight TelescopeBorder guibg=none')
		vim.cmd('highlight TelescopeTitle guibg=none')
	end,
}
