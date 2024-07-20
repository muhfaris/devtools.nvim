local J = {}
local _encode = require("devtools.actions.encode")

function J.parse_json(input)
	local function parse_object(input)
		local obj = {}
		input = input:gsub('{%s*"', ""):gsub('"%s*:%s*', '":'):gsub('"%s*,%s*"', '","')
		for k, v in input:gmatch('"(.-)":(.-),') do
			obj[k] = v
		end
		return obj
	end

	local first_char = input:sub(1, 1)
	if first_char == "{" then
		return parse_object(input)
	else
		return nil
	end
end

function J.parse(jwt_token)
	local token = jwt_token
	-- if jwt_token is table
	if type(jwt_token) == "table" then
		token = jwt_token[1]
	end

	if not token or type(token) ~= "string" then
		print("Invalid token")
		return
	end

	local header_b64, payload_b64, signature_b64 = token:match("([^.]+)%.([^.]+)%.([^.]+)")

	if not (header_b64 and payload_b64 and signature_b64) then
		return nil, "Invalid JWT format"
	end

	local header = _encode.base64_decode(header_b64)
	local payload = _encode.base64_decode(payload_b64)

	return {
		header = header,
		payload = payload,
		signature = signature_b64,
	}
end

function J.v_parse()
	local current_line = vim.api.nvim_get_current_line()
	local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1

	local start_col = cursor_col
	while start_col > 0 and current_line:sub(start_col, start_col) ~= " " do
		start_col = start_col - 1
	end
	start_col = start_col + 1

	local end_col = cursor_col
	while end_col <= #current_line and current_line:sub(end_col, end_col) ~= " " do
		end_col = end_col + 1
	end
	end_col = end_col - 1

	local token = current_line:sub(start_col, end_col)
	J.show_popup(token)
end

function J.show_popup(token)
	local popup_win_id = nil
	if popup_win_id ~= nil and vim.api.nvim_win_is_valid(popup_win_id) then
		vim.api.nvim_win_close(popup_win_id, true) -- Close the existing popup if it is still open
	end

	local jwt, err = J.parse(token)
	if jwt then
		local content = {
			"Header: " .. vim.inspect(jwt.header),
			"Payload: " .. vim.inspect(jwt.payload),
			"Signature: " .. jwt.signature,
		}

		-- Create a floating window to display the JWT content
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

		local opts = {
			relative = "cursor",
			width = math.max(vim.api.nvim_win_get_width(0) - 4, 20),
			height = #content,
			col = 1,
			row = 1,
			style = "minimal",
			border = "rounded",
			title = "Decode JWT",
		}

		popup_win_id = vim.api.nvim_open_win(buf, false, opts)
		-- Automatically close the popup when the cursor moves
		vim.cmd("autocmd CursorMoved * ++once lua vim.api.nvim_win_close(" .. popup_win_id .. ", true)")
	else
		print("Error:", err)
	end
end

return J
