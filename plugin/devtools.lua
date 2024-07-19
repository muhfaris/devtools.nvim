-- Check if devtools is already loaded
if vim.g.loaded_devtools then
	return
end
vim.g.loaded_devtools = true

-- Define the Devtools command
vim.api.nvim_create_user_command("DevTools", function(opts)
	require("devtools").execute(opts.fargs)
end, {
	range = true,
	nargs = 1,
	complete = function(arglead, cmdline, cursorpos)
		return require("devtools").complete_tools(arglead, cmdline, cursorpos)
	end,
})
