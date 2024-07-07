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

return _common
