local mappings = {}
local _actions = require("devtools.actions").tools

mappings.default = {
	v = {
		["<Leader><Leader>djp"] = {
			func = _actions.json.parse.func,
			desc = "DevTools: Parse json string to object",
		},
		["<Leader><Leader>dje"] = {
			func = _actions.json.escape.func,
			desc = "DevTools: Escape the json object",
		},
		["<Leader><Leader>dbe"] = {
			func = _actions.encode.v_base64_encode.func,
			desc = "DevTools: Encode base64",
		},
		["<Leader><Leader>dbd"] = {
			func = _actions.encode.v_base64_decode.func,
			desc = "DevTools: Decode base64",
		},
	},
	n = {
		["<Leader><Leader>dip"] = {
			func = _actions.net.my_ip.func,
			desc = "DevTools: Get my public IP address",
		},
		["<Leader><Leader>djwt"] = {
			func = _actions.jwt.decode_token.func,
			desc = "DevTools: Decode JWT token",
		},
	},
}

return mappings
