local workspaces = require("workspaces")

vim.keymap.set("n", "<leader>fw", "<cmd>Telescope workspaces<CR>")

local opts = {
	path = vim.fn.stdpath("data") .. "/workspaces",
	cd_type = "global",
	sort = true,
	auto_open = true,
	hooks = {
		add = {},
		remove = {},
		rename = {},
		open_pre = {},
		open =  function(name, path, state)
			vim.cmd(string.format("Ex %s", path))
		end
	},
}

workspaces.setup(opts)

