return {
    -- Let Lazy manage itself
    "folke/lazy.nvim",

    { "scrooloose/nerdtree", cmd = { 'NERDTree', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeToggle' } },
    "tpope/vim-commentary",
    "tpope/vim-fugitive",

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
            },
            "williamboman/mason-lspconfig.nvim",
            "mfussenegger/nvim-dap",
            "jose-elias-alvarez/null-ls.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            { "ii14/emmylua-nvim", ft = "lua" },
        },
    },

    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        build = "make",
        config = function()
            require('avante').setup({
                -- add any opts here
            })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                config = function()
                    require('render-markdown').setup({
                        file_types = { "markdown", "Avante" },
                    })
                end,
                ft = { "markdown", "Avante" },
            },
        },
    },

    "junegunn/vim-easy-align",
    "mhinz/vim-startify",
    "jwalton512/vim-blade",

    { 
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "rust", "javascript", "html" },
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },

    "nvim-treesitter/nvim-treesitter-context",
    "nvim-lualine/lualine.nvim",
    "lewis6991/gitsigns.nvim",

    -- Color schemes
    "sainnhe/gruvbox-material",
    "sainnhe/edge",
    "sainnhe/everforest",
    "sainnhe/sonokai",
    "ellisonleao/gruvbox.nvim",
    "mhartington/oceanic-next",
    "savq/melange",
    "ishan9299/nvim-solarized-lua",
    "marko-cerovac/material.nvim",

    "kyazdani42/nvim-web-devicons",
}
