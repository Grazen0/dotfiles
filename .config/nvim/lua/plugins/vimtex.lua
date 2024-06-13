return {
	'lervag/vimtex',
	lazy = false,
	init = function()
		vim.g.tex_flavor = 'latex'
		vim.g.vimtex_quickfix_mode = 0

		vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
		vim.g.vimtex_view_general_options = '-reuse-instance @pdf'
	end,
}
