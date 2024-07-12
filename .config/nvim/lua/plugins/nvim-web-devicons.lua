return {
	'nvim-tree/nvim-web-devicons',
	opts = {
		strict = true,
		override_by_filename = {
			makefile = {
				icon = '',
				color = '#cc3e44',
				cterm_color = '160',
				name = 'Makefile',
			},
		},
		override_by_extension = {
			asm = {
				icon = '',
				color = '#f54d27',
				cterm_color = '196',
				name = 'Asm',
			},
			inc = {
				icon = '',
				color = '#6d8086',
				cterm_color = '66',
				name = 'Inc',
			},
		},
	},
}
