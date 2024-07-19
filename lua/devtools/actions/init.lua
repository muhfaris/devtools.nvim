local _json = require("devtools.actions.json")
local _net = require("devtools.actions.network")
local _word = require("devtools.actions.word")
local _file = require("devtools.actions.file")
local _encode = require("devtools.actions.encode")

local A = {
	tools = {
		json = {
			parse = {
				func = _json.json_parse,
				is_command = true,
				is_key_bind = true,
			},
			escape = {
				func = _json.json_escape,
				is_command = true,
				is_key_bind = true,
			},
		},
		net = {
			my_ip = {
				func = _net.fetch_ip,
				is_command = true,
				is_key_bind = true,
			},
		},
		word = {
			wrap = {
				func = _word.word_wrap,
				is_command = false,
				is_key_bind = false,
			},
		},
		files = {
			compare = {
				func = _file.compare_and_highlight,
				is_command = true,
				is_key_bind = false,
			},
		},
		encode = {
			v_base64_encode = {
				func = _encode.base64_encode,
				is_command = false,
				is_key_bind = true,
			},
			v_base64_decode = {
				func = _encode.base64_decode,
				is_command = false,
				is_key_bind = true,
			},
			base64_encode = {
				func = _encode.base64_encode,
				is_command = true,
				is_key_bind = false,
			},
			base64_decode = {
				func = _encode.base64_decode,
				is_command = true,
				is_key_bind = false,
			},
		},
	},
}

function A.call(actionName)
	-- Split the actionName into parts
	local parts = vim.split(actionName, "%.")

	-- Traverse the `A` table to find the corresponding action
	local current = A.tools
	for _, part in ipairs(parts) do
		if current[part] then
			current = current[part]
		else
			return nil, ("Action not found: " .. actionName)
		end
	end

	-- Ensure that the action has a function to call
	if type(current) == "table" and current.func then
		-- Call the function
		return current.func, nil
	else
		return nil, ("No function defined for action: " .. actionName)
	end
end

function A.get_tools()
	return A.tools
end

return A
