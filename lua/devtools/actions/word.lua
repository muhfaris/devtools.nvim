local W = {}

function W.word_wrap(opts)
	opts = opts
		or {
			markdown = {
				wrap = true,
				textwidth = 80,
				linebreak = true,
			},
			text = {
				wrap = true,
				textwidth = 80,
				linebreak = true,
			},
		}

	for filetype, settings in pairs(opts) do
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetype,
			callback = function()
				vim.opt_local.wrap = settings.wrap
				vim.opt_local.textwidth = settings.textwidth
				vim.opt_local.linebreak = settings.linebreak
			end,
		})
	end
end

return W
