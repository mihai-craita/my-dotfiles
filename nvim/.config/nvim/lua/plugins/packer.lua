-- install packer from github if is not found on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- make sure to add this line to let packer manage itself
    use 'wbthomason/packer.nvim'

    use { 'scrooloose/nerdtree', cmd = { 'NERDTree', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeToggle' } }
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            {'mfussenegger/nvim-dap'},             -- Optional
            {'jose-elias-alvarez/null-ls.nvim'},   -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required

            {'rafamadriz/friendly-snippets'}, -- snipets source
            {'ii14/emmylua-nvim', ft = { 'lua' }} -- neovim completion library for lua language nvim library
        }
    }

    use 'junegunn/vim-easy-align'
    use 'mhinz/vim-startify'
    use 'jwalton512/vim-blade'

    -- Highlight, edit, and navigate code
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        after = 'telescope.nvim'
    }

    -- show context up
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'nvim-lualine/lualine.nvim' -- Fancier statusline

    -- colors packs, find more on http://vimcolors.com/
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/edge'
    use 'sainnhe/everforest'
    use 'sainnhe/sonokai'
    use 'ellisonleao/gruvbox.nvim'
    use 'mhartington/oceanic-next'
    use 'savq/melange'
    use 'ishan9299/nvim-solarized-lua'
    use 'marko-cerovac/material.nvim'

    use 'kyazdani42/nvim-web-devicons' -- fonts

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end
