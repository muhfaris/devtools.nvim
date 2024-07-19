local _v = vim
local _common = {}

function _common.get_visual_selection()
	_v.cmd('noau normal! "vy"')
	local text = _v.fn.getreg("v")
	_v.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

function _common.replace_selection(data)
	-- Delete the selected text
	_v.cmd("normal! gvd")
	-- Put the new text in the register
	_v.fn.setreg("v", data)
	-- Paste the new text
	_v.cmd('normal! "vp')

	-- Optionally, move the cursor to the end of the newly inserted text
	_v.cmd("normal! `[v`]h")
end

function _common.get_visual_selection_cmd()
	-- Get the start and end positions of the visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Get the lines in the visual selection
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	-- If the selection is within a single line
	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
	else
		lines[1] = string.sub(lines[1], start_pos[3])
		lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
	end

	-- Join the lines into a single string
	local selection = table.concat(lines, "\n")

	-- Remove newlines from the selection
	selection = selection:gsub("\n", "")

	-- Remove spaces from the selection
	selection = selection:gsub("%s", "")

	-- Remove leading and trailing whitespace
	selection = selection:gsub("^%s*(.-)%s*$", "%1")

	return selection
end

return _common
