local format_opts = {
	timeout_ms = 500,
	lsp_format = false,
}

return {
	'stevearc/conform.nvim',
	opts = {
		format_on_save = format_opts,
		formatters_by_ft = {
			html = { { 'prettierd', 'prettier' } },
			javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
			typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
			javascript = { 'prettierd', 'prettier', stop_after_first = true },
			typescript = { 'prettierd', 'prettier', stop_after_first = true },
			graphql = { 'prettierd', 'prettier', stop_after_first = true },
			json = { 'prettierd', 'prettier', stop_after_first = true },
			css = { 'prettierd', 'prettier', stop_after_first = true },
			python = { 'isort', 'black' },
			lua = { 'stylua' },
			rust = { 'rustfmt' },
			c = { 'clang-format' },
			cpp = { 'clang-format' },
			yaml = { 'prettierd' },
			sh = { 'beautysh' },
			bash = { 'beautysh' },
			zsh = { 'beautysh' },
		},
	},
	config = function(_, opts)
		local conform = require('conform')
		conform.setup(opts)

		conform.formatters.latexindent = {
			prepend_args = {
				'-c',
				'/home/jdgt/.config/nvim',
			},
		}

		vim.api.nvim_create_user_command('Format', function()
			conform.format(format_opts)
		end, { range = true })
	end,
}
