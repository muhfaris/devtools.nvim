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

return _common
