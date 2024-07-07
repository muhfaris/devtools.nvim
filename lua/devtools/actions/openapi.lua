local openapi = {}

function openapi.setup(config)
	config = config or {}
	openapi.port = config.port or 4000
	openapi.host = config.host or "localhost"
end

openapi.server_on = false
openapi.file_being_previewed = nil

function openapi.start_server()
	local swagger_path = vim.fn.expand("%:p")

	if swagger_path == openapi.file_being_previewed then
		return
	end

	if openapi.server_on then
		openapi.stop_server()
	end

	local cmd = "swagger-ui-watcher -p " .. openapi.port .. " -h " .. openapi.host .. " " .. swagger_path

	openapi.server_pid = vim.fn.jobstart(cmd, {
		on_stdout = function(_, data, _)
			print(vim.inspect(data))
		end,
		on_stderr = function(_, data, _)
			print(vim.inspect(data))
		end,
		on_exit = function(_, code, _)
			print("swagger-ui-watcher exited with code " .. code)
		end,
	})
	openapi.server_on = true
	openapi.file_being_previewed = swagger_path
end

function openapi.stop_server()
	if openapi.server_pid then
		vim.fn.jobstop(openapi.server_pid)
		openapi.server_pid = nil
	end
	openapi.server_on = false
	openapi.file_being_previewed = nil
end

function openapi.toggle_server()
	if openapi.server_on then
		openapi.stop_server()
	else
		openapi.start_server()
	end
end

return openapi
