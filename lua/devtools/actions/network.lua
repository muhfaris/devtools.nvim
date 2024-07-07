local N = {}

function N.fetch_ip()
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

return N
