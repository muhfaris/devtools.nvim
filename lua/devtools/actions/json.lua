local _v = vim
local _c = require("devtools.actions.common")
local JSON = {}

function JSON.json_parse()
	local text = _c.get_visual_selection()
	local raw = _v.fn.json_decode(text)

	_c.replace_selection(raw)
	return raw
end

function JSON.json_escape()
	local text = _c.get_visual_selection()
	local json_string = vim.fn.json_encode(text)

	-- Escape double quotes for the JSON string
	local remove_t = json_string:gsub("\\t", "")
	_c.replace_selection(remove_t)
end

return JSON
