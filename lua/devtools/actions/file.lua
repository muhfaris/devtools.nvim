local M = {}

-- Function to read the contents of a file into a table (each line as an element)
local function read_file(filepath)
	local lines = {}
	local file = io.open(filepath, "r")
	if file then
		for line in file:lines() do
			table.insert(lines, line)
		end
		file:close()
	end
	return lines
end

-- Function to split a string into words
local function split_into_words(line)
	local words = {}
	for word in line:gmatch("%S+") do
		table.insert(words, word)
	end
	return words
end

-- Function to compare two lines and return differing words with their positions
local function compare_lines(line1, line2)
	local words1 = split_into_words(line1)
	local words2 = split_into_words(line2)
	local diff_words = {}

	local max_length = math.max(#words1, #words2)
	for i = 1, max_length do
		if words1[i] ~= words2[i] then
			table.insert(diff_words, {
				word = words2[i] or "",
				position = i,
				type = words1[i] and words2[i] and "modified" or (words2[i] and "added" or "removed"),
			})
		end
	end

	return diff_words
end

-- Function to highlight words in the current buffer
local function highlight_words(buffer, line_number, words, highlight_group)
	for _, word_info in ipairs(words) do
		if word_info.type == highlight_group then
			-- Find the start position of the word in the line
			local start_pos = string.find(line_number, word_info.word)
			if start_pos then
				vim.api.nvim_buf_add_highlight(
					buffer,
					-1,
					highlight_group,
					line_number - 1,
					start_pos - 1,
					start_pos + #word_info.word - 1
				)
			end
		end
	end
end

-- Main function to compare and highlight files
function M.compare_and_highlight(...)
	local buffers = vim.fn.getbufinfo({ bufloaded = 1 })
	if #buffers < 2 then
		print("Not enough buffers to compare")
		return
	end

	-- List buffer names and IDs
	for i, buf in ipairs(buffers) do
		print(i .. ": " .. buf.name)
	end

	-- Prompt user to pick buffers
	print("Pick first buffer:")
	local buf1_idx = tonumber(vim.fn.input("Buffer number: "))
	print("Pick second buffer:")
	local buf2_idx = tonumber(vim.fn.input("Buffer number: "))

	local args = { ... }
	local file1 = ""
	local file2 = ""

	for _, value in pairs(args) do
		for _, v in pairs(value) do
			if file1 == "" then
				file1 = v
			else
				file2 = v
			end
		end
	end

	if file1 == "" or file2 == "" then
		vim.api.nvim_out_write("Not enough arguments\n")
		return
	end

	local lines1 = read_file(file1)
	local lines2 = read_file(file2)
	local buffer = vim.api.nvim_get_current_buf()

	for i = 1, math.max(#lines1, #lines2) do
		local line1 = lines1[i] or ""
		local line2 = lines2[i] or ""
		local diff_words = compare_lines(line1, line2)

		highlight_words(buffer, i, diff_words, "DiffModified")
		highlight_words(buffer, i, diff_words, "DiffAdded")
		highlight_words(buffer, i, diff_words, "DiffRemoved")
	end
end

-- Set highlight groups
vim.api.nvim_set_hl(0, "DiffAdded", { bg = "Green" })
vim.api.nvim_set_hl(0, "DiffModified", { bg = "Yellow" })
vim.api.nvim_set_hl(0, "DiffRemoved", { bg = "Red" })

return M
