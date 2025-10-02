local builtin = require('telescope.builtin')
local telescope = require('telescope')

telescope.setup {
    pickers = {
        find_files = {
            hidden = false,
	    shorten_path=true,
        }
    },

    defaults = {
	    path_display = {
		    filename_first = {
			    reverse_directories = false,
		    }
	    },
	    sorting_strategy = "ascending",
	    layout_strategy = "horizontal",
	    layout_config = {
		    horizontal = {
			    prompt_position = "bottom",
		    }
	    },
    }
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
