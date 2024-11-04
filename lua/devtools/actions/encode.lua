local E = {}
local _c = require("devtools.actions.common")

local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- Base64 encode
local function base64_encode(data)
	return (
		(data:gsub(".", function(x)
			local r, b = "", x:byte()
			for i = 8, 1, -1 do
				r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
			end
			return r
		end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
			if #x < 6 then
				return ""
			end
			local c = 0
			for i = 1, 6 do
				c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
			end
			return b:sub(c + 1, c + 1)
		end) .. ({ "", "==", "=" })[#data % 3 + 1]
	)
end

-- Base64 decode
local function base64_decode(data)
	data = string.gsub(data, "[^" .. b .. "=]", "")
	return (
		data:gsub(".", function(x)
			if x == "=" then
				return ""
			end
			local r, f = "", (b:find(x) - 1)
			for i = 6, 1, -1 do
				r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
			end
			return r
		end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
			if #x ~= 8 then
				return ""
			end
			local c = 0
			for i = 1, 8 do
				c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
			end
			return string.char(c)
		end)
	)
end

function E.v_base64_encode()
	local text = _c.get_visual_selection()
	local encoded = base64_encode(text)
	encoded = encoded:gsub("%s+", "") -- remove any whitespace
	return _c.replace_selection(encoded)
end

function E.v_base64_decode()
	local text = _c.get_visual_selection()
	text = text:gsub("%s+", "") -- remove any whitespace
	local decoded = base64_decode(text)
	return _c.replace_selection(decoded)
end

function E.base64_encode(...)
	local texts = ...
	local text = texts

	-- if table type
	if type(texts) == "table" then
		text = table.concat(texts, " ")
	end

	local encoded = base64_encode(text)
	encoded = encoded:gsub("%s+", "") -- remove any whitespace
	print(encoded)
end

function E.base64_decode(...)
	local texts = ...
	local text = texts

	-- if table type
	if type(texts) == "table" then
		text = table.concat(texts, " ")
	end

	local decoded = base64_decode(text)
	-- decoded = decoded:gsub("%s+", "") -- remove any whitespace
	print(decoded)
end

return E
