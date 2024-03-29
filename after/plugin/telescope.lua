local builtin = require('telescope.builtin')
local telescope = require('telescope')

telescope.load_extension("workspaces")

telescope.setup {
    pickers = {
        find_files = {
            hidden = false
        }
    }
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
