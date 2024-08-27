-- install packer from github if is not found on the system
require('packer').startup(function(use)
    -- make sure to add this line to let packer manage itself
    use 'wbthomason/packer.nvim'

    use { 'scrooloose/nerdtree', cmd = { 'NERDTree', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeToggle' } }
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
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
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/nvim-cmp'},     -- Required
            {'L3MON4D3/LuaSnip'},     -- Required

            {'rafamadriz/friendly-snippets'}, -- snipets source
            {'ii14/emmylua-nvim', ft = { 'lua' }} -- neovim completion library for lua language nvim library
        }
    }

    use {
        'yetone/avante.nvim',
        cmd = 'Avante',
        -- after = 'VimEnter', 
        -- run = 'make',
        config = function()
            require('avante').setup({
                -- add any opts here
            })
        end,
        requires = {
            'nvim-tree/nvim-web-devicons', -- or 'echasnovski/mini.icons'
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            {
                'MeanderingProgrammer/render-markdown.nvim',
                config = function()
                    require('render-markdown').setup({
                        file_types = { "markdown", "Avante" },
                    })
                end,
                ft = { "markdown", "Avante" },
            },
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

    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    use 'lewis6991/gitsigns.nvim'

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
