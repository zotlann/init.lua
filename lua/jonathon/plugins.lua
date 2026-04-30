-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- set leader key here as required by lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "


return require('lazy').setup({

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },

    'mbbill/undotree',
    'mfussenegger/nvim-dap',
	'nvim-neotest/nvim-nio',
    'jayp0521/mason-nvim-dap.nvim',
    'rcarriga/nvim-dap-ui',
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            --{ 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    },

	{ "catppuccin/nvim", name = "catppuccin"},
	{"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
	{
		'github/copilot.vim'
	},
	-- lazy.nvim
	{
	  "GustavEikaas/easy-dotnet.nvim",
	  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
	  config = function()
	    require("easy-dotnet").setup()
	  end
	},

})
