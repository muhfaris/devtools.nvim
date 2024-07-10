local mappings = {}
local _actions = require("devtools.actions")

mappings.default = {
	v = {
		["<Leader>jp"] = {
			func = _actions.json.parse.func,
			desc = "Parse json string to object",
		},
		["<Leader>je"] = {
			func = _actions.json.escape.func,
			desc = "Parse into json string",
		},
		["<Leader>be"] = {
			func = _actions.encode.v_base64_encode.func,
			desc = "Encode base64",
		},
		["<Leader>bd"] = {
			func = _actions.encode.v_base64_decode.func,
			desc = "Decode base64",
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
