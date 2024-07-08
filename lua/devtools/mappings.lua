local mappings = {}
local _actions = require("devtools.actions")

mappings.default = {
	v = {
		["<Leader>jp"] = {
			func = _actions.json.parse.func,
			desc = "Parse json string to object",
		},
		["<Leader>js"] = {
			func = _actions.json.string.func,
			desc = "Parse into json string",
		},
	},
	n = {
		["<Leader>mip"] = {
			func = _actions.net.my_ip.func,
			desc = "Get my public IP address",
		},
	},
}

return mappings
