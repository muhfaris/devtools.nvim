-- Check if devtools is already loaded
if vim.g.loaded_devtools then
	return
end
vim.g.loaded_devtools = true

-- Define the Devtools command
vim.api.nvim_create_user_command("DevTools", function(opts)
	require("devtools").execute(opts.args)
end, {
	nargs = 1,
	complete = function(arglead, cmdline, cursorpos)
		return require("devtools").complete_tools(arglead, cmdline, cursorpos)
	end,
})

local openapi = require("devtools.openapi")

-- Define commands to call the start/stop/toggle server functions
vim.api.nvim_create_user_command("SwaggerPreview", function()
	openapi.start_server()
end, {})
vim.api.nvim_create_user_command("SwaggerPreviewStop", function()
	openapi.stop_server()
end, {})
vim.api.nvim_create_user_command("SwaggerPreviewToggle", function()
	openapi.toggle_server()
end, {})

-- Autocommand to start/stop the server based on file events
vim.api.nvim_create_augroup("SwaggerPreviewGroup", { clear = true })

-- Add patterns for different filenames
local swagger_patterns = { "openapi.yaml", "openapi-spec.yaml" }

for _, pattern in ipairs(swagger_patterns) do
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = "SwaggerPreviewGroup",
		pattern = pattern,
		callback = function()
			openapi.start_server()
		end,
	})
end

vim.api.nvim_create_autocmd("BufEnter", {
	group = "SwaggerPreviewGroup",
	callback = function()
		local file_name = vim.fn.expand("%:t")
		if not vim.tbl_contains(swagger_patterns, file_name) then
			openapi.stop_server()
		end
	end,
})
