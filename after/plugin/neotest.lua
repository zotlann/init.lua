local neotest = require("neotest")
local gtest = require("neotest-gtest")
local neotest_lib = require("neotest.lib")
local gtest_config = require("neotest-gtest.config")

neotest.setup({
	adapters = {
		gtest.setup({
			root = neotest_lib.files.match_root_pattern(".git"),
			is_test_file = function(file)
				return string.find(file, "Test") and string.match(file, ".cpp$")
			end,
			debug_adapter = "codelldb",
			history_size = 3,
			parsing_throttle_ms = 10,
			mappings = { configure = nil },
			summary_view = {
				header_length = 80,
				shell_palette = {
					passed = "\27[32m",
					skipped = "\27[33m",
					failed = "\27[31m",
					stop = "\27[0m",
					bodl = "\27[1m",
				},
			},
			extra_args = "--gtest_shuffle",
		})
	},
})

-- bindings
vim.keymap.set("n", "<leader>tt", neotest.summary.toggle)
vim.keymap.set("n", "<leader>tr", neotest.run.run)
vim.keymap.set("n", "<leader>ts", neotest.run.stop)
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>tu", function() neotest.output.open({ enter = true }) end)
vim.keymap.set("n", "<leader>ta", function()
									local args = vim.fn.input('Program arguments: ')
									local cfg = gtest_config.get_config()
									cfg.extra_args = args
								end)
