local M = {}
local _loaded = false
local _mappings = require("devtools.mappings")
local _word = require("devtools.actions.word")
local _actions = require("devtools.actions")

-- Function to register key mappings
local function register_mappings(mappings)
	for mode, mode_mappings in pairs(mappings) do
		for key, action in pairs(mode_mappings) do
			vim.keymap.set(mode, key, action.func, { desc = action.desc })
		end
	end
end

function M.setup(opts)
	local default_opts = {
		actions = _actions,
	}

	opts = opts or {}
	table.insert(opts, default_opts)

	opts.mappings = opts.mappings or _mappings.default
	register_mappings(opts.mappings)
	_word.word_wrap(opts.word_wrap)

	-- assign opts
	M.opts = opts
end

function M.execute(...)
	local args = { ... }
	local tool_name = ""
	for _, arg_value in pairs(args) do
		for _, arg in pairs(arg_value) do
			local req_args = vim.split(arg, " ")
			tool_name = req_args[1]
			table.remove(req_args, 1)

			-- Overwrite the args
			args = req_args
		end
	end

	if M.tools == nil then
		local tools, tools_name = M.load_tools()
		if tools == nil or tools_name == nil then
			vim.api.nvim_out_write("Not available tools: " .. tool_name .. "\n")
			return
		end
	end

	local _tool = M.tools[tool_name]
	if _tool ~= nil and args ~= nil then
		_tool(args)
	elseif _tool ~= nil then
		_tool(true)
	else
		vim.api.nvim_out_write("Tool not found: " .. tool_name .. "\n")
	end
end

function M.complete_tools(arglead, cmdline, cursorpos)
	if not _loaded then
		local tools, tools_name = M.load_tools()
		if tools == nil or tools_name == nil then
			return M.tools_name
		end

		_loaded = true
	end

	return M.tools_name
end

function M.load_tools()
	local _config = require("devtools.config").register_tools()
	if _config == nil then
		return nil, nil
	end

	if _config.completed_tools == nil then
		return nil, nil
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
	return tools, tools_name
end

return M
