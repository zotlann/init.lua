local neotest = require("neotest")
local gtest = require("neotest-gtest")

neotest.setup({
	adapters = {
		gtest.setup({
		})
	},
})
