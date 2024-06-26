local M = {} -- M stands for module, a naming convention
local tb = require("telescope.builtin")
local openapi = require("devtools.openapi")

require("devtools.openapi")

function M.setup(opts)
	opts = opts or {}
	local swagger_patterns = { "openapi.yaml", "openapi-spec.yaml" }

	M.swagger_patterns = opts.swagger_patterns or swagger_patterns
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

	openapi.setup(opts.openapi)
	M.autoload()
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

function M.swaggerPreview()
	openapi.start_server()
end

function M.swaggerStop()
	openapi.stop_server()
end

function M.swaggerToggle()
	openapi.toggle_server()
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
	return { "fetch_ip", "jsonparse", "swaggerPreview", "swaggerStop", "swaggerToggle" }
end

function M.autoload()
	-- Autocommand to start/stop the server based on file events
	vim.api.nvim_create_augroup("SwaggerPreviewGroup", { clear = true })

	-- Add patterns for different filenames
	for _, pattern in ipairs(M.swagger_patterns) do
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			group = "SwaggerPreviewGroup",
			pattern = pattern,
			callback = function()
				M.swaggerPreview()
			end,
		})
	end

	vim.api.nvim_create_autocmd("BufEnter", {
		group = "SwaggerPreviewGroup",
		callback = function()
			local file_name = vim.fn.expand("%:t")
			if not vim.tbl_contains({}, file_name) then
				M.swaggerStop()
			end
		end,
	})
end

return M
