format_opts = {
	timeout_ms = 500,
	lsp_format = false,
}

return {
	'stevearc/conform.nvim',
	opts = {
		format_on_save = format_opts,
		formatters_by_ft = {
			javascriptreact = { 'prettierd' },
			typescriptreact = { 'prettierd' },
			javascript = { 'prettierd' },
			typescript = { 'prettierd' },
			graphql = { 'prettierd' },
			json = { 'prettierd' },
			css = { 'prettierd' },
			python = { 'isort', 'black' },
			lua = { 'stylua' },
		},
	},
	config = function(_, opts)
		local conform = require('conform')
		conform.setup(opts)

		vim.api.nvim_create_user_command('Format', function()
			conform.format(format_opts)
		end, { range = true })
	end,
}
