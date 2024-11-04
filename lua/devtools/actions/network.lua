local N = {}

function N.fetch_ip()
	local handle = io.popen("curl -s https://api.ipify.org")
	if handle == nil then
		return "Failed to execute curl command."
	end

	local result = handle:read("*a")
	handle:close()

	if result then
		print("Your public IP address is: " .. result)
		return
	else
		return "Failed to retrieve IP address."
	end
end

return N
