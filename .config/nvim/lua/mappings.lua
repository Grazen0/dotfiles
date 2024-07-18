local keyset = vim.keymap.set
local opts = { noremap = true, silent = true }

keyset('n', '<Esc><Esc>', ':noh<CR>', opts)

keyset('n', '<C-h>', '<C-W>h', opts)
keyset('n', '<C-j>', '<C-W>j', opts)
keyset('n', '<C-k>', '<C-W>k', opts)
keyset('n', '<C-l>', '<C-W>l', opts)

keyset('n', '<A-h>', '<C-W>H', opts)
keyset('n', '<A-j>', '<C-W>J', opts)
keyset('n', '<A-k>', '<C-W>K', opts)
keyset('n', '<A-l>', '<C-W>L', opts)

keyset('n', '<lt>', '<C-W><lt>', opts)
keyset('n', '>', '<C-W>>', opts)
keyset('n', '-', '<C-W>-', opts)
keyset('n', '+', '<C-W>+', opts)

-- Soft line wrap movement
vim.cmd([[
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
]])

-- LaTeX spell correction
keyset('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<C-g>u', opts)
