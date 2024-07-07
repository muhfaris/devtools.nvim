local _v = vim
local _c = require("devtools.actions.common")
local JSON = {}

function JSON.json_parse()
  local text = _c.get_visual_selection()
  local raw = _v.fn.json_decode(text)

  -- Delete the selected text
  _v.cmd("normal! gvd")
  -- Put the new text in the register
  _v.fn.setreg("v", raw)
  -- Paste the new text
  _v.cmd('normal! "vp')

  -- Optionally, move the cursor to the end of the newly inserted text
  _v.cmd("normal! `[v`]h")
  return raw
end

return JSON
