return {
	'SirVer/ultisnips',
	init = function()
		vim.g.UltiSnipsExpandTrigger = '<Tab>'
		vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
		vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
	end,
}
