local header = [[
                        Welcome back to                            
                                                                   
 ██████   █████                                ███                 
░░██████ ░░███                                ░░░                  
 ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████  
 ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███ 
 ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███ 
 ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███ 
 █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████
░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ 
]]

return {
	'echasnovski/mini.starter',
	version = '*',
	opts = function()
		local starter = require('mini.starter')

		return {
			header = header,
			footer = '',
			items = {
				function()
					local auto_session = require('auto-session')
					local sessions = auto_session.get_session_files()

					local result = {}

					for _, session in pairs(sessions) do
						table.insert(result, {
							section = 'Recent sessions',
							name = vim.fs.basename(session.display_name)
								.. ' ('
								.. session.display_name
								.. ')',
							action = function()
								auto_session.RestoreSession(session.path)
							end,
						})
					end

					return result
				end,
				starter.sections.builtin_actions(),
			},
			content_hooks = {
				starter.gen_hook.adding_bullet('» '),
				starter.gen_hook.aligning('center', 'center'),
			},
		}
	end,
}
