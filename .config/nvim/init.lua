require('general')

-- Save and restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
	pattern = '*',
	command = 'silent! normal! g`"zv',
})

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
	ui = {
		border = 'rounded',
	},
	install = {
		missing = true,
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
})

require('mappings')
