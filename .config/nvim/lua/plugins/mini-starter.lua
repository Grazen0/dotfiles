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

-- Copied from https://github.com/rmagatti/auto-session/blob/main/lua/auto-session/init.lua
local function get_session_files()
	local AutoSession = require('auto-session')
	local Lib = require('auto-session.lib')

	local files = {}
	local sessions_dir = AutoSession.get_root_dir()

	if vim.fn.isdirectory(sessions_dir) == Lib._VIM_FALSE then
		return files
	end

	local entries = vim.fn.readdir(sessions_dir, function(item)
		return Lib.is_session_file(sessions_dir .. item)
	end)

	return vim.tbl_map(function(file_name)
		--  sessions_dir is guaranteed to have a trailing separator so don't need to add another one here
		local session_name
		local display_name
		if Lib.is_legacy_file_name(file_name) then
			session_name = (
				Lib.legacy_unescape_session_name(file_name):gsub('%.vim$', '')
			)
			display_name = session_name .. ' (legacy)'
		else
			session_name = Lib.escaped_session_name_to_session_name(file_name)
			display_name = Lib.get_session_display_name(file_name)
		end

		return {
			session_name = session_name,
			display_name = display_name,
			path = sessions_dir .. file_name,
		}
	end, entries)
end

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
					local sessions = get_session_files()
					local result = {}

					for _, session in pairs(sessions) do
						table.insert(result, {
							section = 'Recent sessions',
							name = vim.fs.basename(session.display_name)
								.. ' ('
								.. session.display_name
								.. ')',
							action = function()
								vim.cmd(
									':SessionRestore ' .. session.display_name
								)
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
