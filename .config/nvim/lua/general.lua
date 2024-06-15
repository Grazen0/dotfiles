local g = vim.g
local o = vim.opt

g.mapleader = ','

g.python3_host_prog = '/home/jdgt/.venv/bin/python3.11'

o.encoding = 'utf-8'
o.compatible = false

vim.cmd('filetype plugin indent on')
vim.cmd 'set clipboard+=unnamedplus'

o.autoindent = true
o.expandtab = false
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4

o.syntax = 'on'
o.showmatch = true
o.ignorecase = true
o.hlsearch = true
o.incsearch = true
o.number = true
o.wildmode = 'longest,list'
o.colorcolumn = '80'
o.mouse = 'a'
o.cursorline = true
o.ttyfast = true
o.termguicolors = true

o.showmatch = false

o.spelllang = { 'en_us', 'es_es' }
vim.cmd([[
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<C-g>u
]])

