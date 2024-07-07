local _default_conf = {}
local _actions = require("devtools.actions")

function _default_conf.register_tools()
	local completed_tools = {}
	for category, toolset in pairs(_actions) do
		for tool, func in pairs(toolset) do
			if func.is_command then
				table.insert(completed_tools, {
					category = category,
					tool = tool,
					func = func.func,
				})
			end
		end
	end
	_default_conf.completed_tools = completed_tools
	return _default_conf
end

return _default_conf
