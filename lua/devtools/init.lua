local M = {} -- M stands for module, a naming convention
local tb = require("telescope.builtin")

require("devtools.openapi")

function M.setup(opts)
	opts = opts or {}
	local keymaps = opts.keymaps or {}

	local jsonparse_key = keymaps.jsonparse or "<Leader>k"
	local vfuzzy_find_key = keymaps.visual_fuzzy_find or "<Leader>f"

	vim.keymap.set("v", jsonparse_key, function()
		M.jsonparse()
	end, { desc = "Parse json string from selection visual text" })

	vim.keymap.set("v", vfuzzy_find_key, function()
		local text = vim.getVisualSelection()
		tb.current_buffer_fuzzy_find({ default_text = text })
	end, { desc = "Find in selection visual text" })
end

function M.jsonparse()
	local text = vim.getVisualSelection()
	local raw = vim.fn.json_decode(text)

	-- Delete the selected text
	vim.cmd("normal! gvd")
	-- Put the new text in the register
	vim.fn.setreg("v", raw)
	-- Paste the new text
	vim.cmd('normal! "vp')

	-- Optionally, move the cursor to the end of the newly inserted text
	vim.cmd("normal! `[v`]h")
	return raw
	-- local raw = require("json").decode(txt)
end

function M.fetch_ip()
	local handle = io.popen("curl -s https://api.ipify.org")
	if handle == nil then
		vim.api.nvim_out_write("Failed to execute curl command.\n")
		return
	end

	local result = handle:read("*a")
	handle:close()

	if result then
		vim.api.nvim_out_write("Your public IP address is: " .. result .. "\n")
	else
		vim.api.nvim_out_write("Failed to retrieve IP address.\n")
	end
end

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

function M.execute(tool_name)
	if M[tool_name] then
		M[tool_name]()
	else
		vim.api.nvim_out_write("Invalid tool name: " .. tool_name .. "\n")
	end
end

function M.complete_tools(arglead, cmdline, cursorpos)
	return { "fetch_ip", "jsonparse" }
end

return M
