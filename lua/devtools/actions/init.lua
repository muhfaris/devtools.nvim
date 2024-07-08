local _json = require("devtools.actions.json")
local _net = require("devtools.actions.network")
local _word = require("devtools.actions.word")
local _file = require("devtools.actions.file")

local A = {
	json = {
		parse = {
			func = _json.json_parse,
			is_command = false,
			is_key_bind = true,
		},
		string = {
			func = _json.json_string,
			is_command = false,
			is_key_bind = true,
		},
	},
	net = {
		my_ip = {
			func = _net.fetch_ip,
			is_command = true,
			is_key_bind = true,
		},
	},
	word = {
		wrap = {
			func = _word.word_wrap,
			is_command = false,
			is_key_bind = false,
		},
	},
	files = {
		compare = {
			func = _file.compare_and_highlight,
			is_command = true,
			is_key_bind = false,
		},
	},
}

return A
