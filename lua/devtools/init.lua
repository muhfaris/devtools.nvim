local M = {}
local _loaded = false
local _mappings = require("devtools.mappings")
local _word = require("devtools.actions.word")

-- Function to register key mappings
local function register_mappings(mappings)
	for mode, mode_mappings in pairs(mappings) do
		for key, action in pairs(mode_mappings) do
			vim.keymap.set(mode, key, action.func, { desc = action.desc })
		end
	end
end

function M.setup(opts)
	opts = opts or {}
	opts.mappings = opts.mappings or _mappings.default
	register_mappings(opts.mappings)
	_word.word_wrap(opts.word_wrap)
end

function M.execute(tool_name)
	local _tool = M.tools[tool_name]

	if _tool ~= nil then
		_tool()
	else
		vim.api.nvim_out_write("Invalid tool name: " .. tool_name .. "\n")
	end
end

function M.complete_tools(arglead, cmdline, cursorpos)
	local matches = {}
	if not _loaded then
		local _config = require("devtools.config").register_tools()
		if _config == nil then
			return matches
		end

		if _config.completed_tools == nil then
			return matches
		end

		local tools = {}
		local tools_name = {}
		for _, tool in pairs(_config.completed_tools) do
			local tool_name = tool.category .. "." .. tool.tool
			tools[tool_name] = tool.func
			table.insert(tools_name, tool_name)
		end

		M.tools = tools
		M.tools_name = tools_name
	end

	return M.tools_name
end

return M
