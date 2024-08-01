local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function mappings(cmp)
	return {
		['<Tab>'] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Insert,
					})
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Insert,
					})
				elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
					vim.api.nvim_feedkeys(
						t('<Plug>(ultisnips_jump_forward)'),
						'm',
						true
					)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
					vim.api.nvim_feedkeys(
						t('<Plug>(ultisnips_jump_forward)'),
						'm',
						true
					)
				else
					fallback()
				end
			end,
		}),
		['<S-Tab>'] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({
						behavior = cmp.SelectBehavior.Insert,
					})
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({
						behavior = cmp.SelectBehavior.Insert,
					})
				elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
					return vim.api.nvim_feedkeys(
						t('<Plug>(ultisnips_jump_backward)'),
						'm',
						true
					)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
					return vim.api.nvim_feedkeys(
						t('<Plug>(ultisnips_jump_backward)'),
						'm',
						true
					)
				else
					fallback()
				end
			end,
		}),
		['<Down>'] = cmp.mapping(
			cmp.mapping.select_next_item({
				behavior = cmp.SelectBehavior.Select,
			}),
			{ 'i' }
		),
		['<Up>'] = cmp.mapping(
			cmp.mapping.select_prev_item({
				behavior = cmp.SelectBehavior.Select,
			}),
			{ 'i' }
		),
		['<C-n>'] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					fallback()
				end
			end,
		}),
		['<C-p>'] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					fallback()
				end
			end,
		}),
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.close(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping({
			i = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					})
				else
					fallback()
				end
			end,
		}),
	}
end

return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'quangnguyen30192/cmp-nvim-ultisnips',
		'onsails/lspkind.nvim',
		'williamboman/mason-lspconfig.nvim',
	},
	config = function()
		local cmp = require('cmp')

		cmp.setup({
			formatting = {
				format = require('lspkind').cmp_format(),
			},
			snippet = {
				expand = function(args)
					vim.fn['UltiSnips#Anon'](args.body)
				end,
			},
			mapping = mappings(cmp),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'ultisnips' },
			}, {
				{ name = 'buffer' },
			}),
		})

		-- Keybindings
		vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
		vim.keymap.set('n', 'gr', function()
			vim.lsp.buf.references({ includeDeclaration = false })
		end)

		-- Search completion
		cmp.setup.cmdline({ '/', '?' }, {
			completion = { autocomplete = false },
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = 'buffer' } },
			view = {
				entries = { name = 'wildmenu', separator = '|' },
			},
		})

		-- Command completion
		cmp.setup.cmdline(':', {
			completion = { autocomplete = false },
			sources = cmp.config.sources(
				{ { name = 'path' } },
				{ { name = 'cmdline' } }
			),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- Disable inline diagnostics
		vim.diagnostic.config({
			virtual_text = false,
		})

		-- Show diagnostics on hover
		vim.o.updatetime = 350
		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			group = vim.api.nvim_create_augroup(
				'float_diagnostic_cursor',
				{ clear = true }
			),
			callback = function()
				vim.diagnostic.open_float(
					nil,
					{ focus = false, scope = 'cursor' }
				)
			end,
		})

		-- Custom icons
		local signs = {
			Error = '󰅙 ',
			Warn = ' ',
			Hint = '󰌵 ',
			Info = ' ',
		}
		for type, icon in pairs(signs) do
			local hl = 'DiagnosticSign' .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
	end,
}
