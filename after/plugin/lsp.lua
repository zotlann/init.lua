local lspconfig = require("lspconfig")
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
	['<CR>']      = cmp.config.disable,
	['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
	['<C-y>']     = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
	['<Tab>']     = cmp.mapping.confirm({ select = true }),
})

local capabilities = cmp_lsp.default_capabilities()

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop('eslint')
		return
	end
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

cmp.setup({
	mapping = cmp_mappings,
	sources = {
		{
			name = 'nvim_lsp'
		},
	},
	experimental = {
		ghost_text = true
	},
})

vim.diagnostic.config({
	virtual_text = true,
})


lspconfig.grammarly.setup({
	filetypes = { "markdown", "text" },
}
)

lspconfig.clangd.setup({
	capabilities = capabilities,
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--clang-tidy-checks="-*"', '--compile-commands-dir=Build' },
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "Lua 5.1" },
			diagnostics = {
				globals = { "vim", },
			}
		}
	},
})

require 'lspconfig'.rust_analyzer.setup {
	capabilities = capabilities,
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = false,
			}
		}
	}
}
