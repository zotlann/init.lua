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
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
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

-- Filter out specific Roslyn diagnostics we don't want to see.
-- CA1859: "Use concrete types when possible for improved performance" — the
-- shared .editorconfig leaves this at default severity, but our codebase
-- intentionally uses interface-typed DI fields throughout.
local suppressed_diagnostic_codes = {
	CA1859 = true,
}

local function filter_suppressed(diagnostics)
	return vim.tbl_filter(function(diag)
		return not suppressed_diagnostic_codes[diag.code]
	end, diagnostics)
end

-- Push diagnostics (older servers like omnisharp use this).
local orig_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
	if result and result.diagnostics then
		result.diagnostics = filter_suppressed(result.diagnostics)
	end
	return orig_publish_diagnostics(err, result, ctx, config)
end

-- Pull diagnostics (Roslyn LSP uses this; LSP 3.17+).
-- Response shape is DocumentDiagnosticReport — full reports have an `items` array.
local orig_pull_diagnostics = vim.lsp.handlers["textDocument/diagnostic"]
if orig_pull_diagnostics then
	vim.lsp.handlers["textDocument/diagnostic"] = function(err, result, ctx, config)
		if result and result.items then
			result.items = filter_suppressed(result.items)
		end
		return orig_pull_diagnostics(err, result, ctx, config)
	end
end

vim.lsp.config('lua_ls', {
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

vim.lsp.config('ts_ls', {
	capabilities = capabilities,
	on_attach = on_attach,
})



vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
