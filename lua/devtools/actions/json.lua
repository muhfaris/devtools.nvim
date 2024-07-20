local _v = vim
local _c = require("devtools.actions.common")
local JSON = {}

function JSON.json_parse(is_command)
	local text
	if is_command then
		text = _c.get_visual_selection_cmd()
	else
		text = _c.get_visual_selection()
	end

	if text == "" then
		return "No text selected"
	end

	local raw = _v.fn.json_decode(text)

	_c.replace_selection(raw)
	return raw
end

function JSON.json_escape(is_command)
	local text
	if is_command then
		text = _c.get_visual_selection_cmd()
	else
		text = _c.get_visual_selection()
	end

	if text == "" then
		return "No text selected"
	end

	local json_string = vim.fn.json_encode(text)

	-- Escape double quotes for the JSON string
	local remove_t = json_string:gsub("\\t", "")
	return _c.replace_selection(remove_t)
end

return JSON
