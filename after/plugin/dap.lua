local dap = require('dap')
local dapui = require('dapui')

--keymaps
vim.keymap.set("n", "<leader>db", dap.continue)
vim.keymap.set("n", "<leader>ds", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>du", dapui.toggle)
vim.keymap.set("n", "<leader>dr", dap.repl.toggle)

dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = '13000',
    executable = {
        command = 'codelldb',
        args = { '--port', '13000' }
    },
}

dap.configurations.cpp = {
    {
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd='${workspaceFolder}',
        externalTerminal = false,
        stopOnEntry = false,
        args = function()
            local argument_string = vim.fn.input('Program arguments: ')
            return vim.fn.split(argument_string, " ", true)
        end,
    },
}

require('dapui').setup()
