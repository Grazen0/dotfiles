local keyset = vim.keymap.set
local opts = { noremap = true, silent = true }

keyset('n', '<Esc><Esc>', ':noh<CR>', opts)

keyset('n', '<A-h>', '<C-W>H', opts)
keyset('n', '<A-j>', '<C-W>J', opts)
keyset('n', '<A-k>', '<C-W>K', opts)
keyset('n', '<A-l>', '<C-W>L', opts)

keyset('n', '<C-h>', '<C-W>h', opts)
keyset('n', '<C-j>', '<C-W>j', opts)
keyset('n', '<C-k>', '<C-W>k', opts)
keyset('n', '<C-l>', '<C-W>l', opts)

keyset('n', '<Tab>', 'gt', opts)
keyset('n', '<S-Tab>', 'gT', opts)
