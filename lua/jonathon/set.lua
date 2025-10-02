vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- try global lsp controls

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)


-- -- Array of file names indicating root directory. Modify to your liking.
-- local root_names = { '.git' }
-- 
-- -- Cache to use for speed up (at cost of possibly outdated results)
-- local root_cache = {}
-- 
-- local set_root = function()
--   -- Get directory path to start search from
--   local path = vim.api.nvim_buf_get_name(0)
--   if path == '' then return end
--   path = vim.fs.dirname(path)
-- 
--   -- Try cache and resort to searching upward for root directory
--   local root = root_cache[path]
--   if root == nil then
--     local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
--     if root_file == nil then return end
--     root = vim.fs.dirname(root_file)
--     root_cache[path] = root
--   end
-- 
--   -- Set current directory
--   vim.fn.chdir(root)
-- end
-- 
-- local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
-- vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
