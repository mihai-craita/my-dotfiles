--
-- LUA config file
--
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.list = false
-- Enable break indent
vim.opt.breakindent = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.cursorline = true
vim.opt.scrolloff = 12

vim.opt.belloff = all

-- use true colors palette on 24 bits (16 million colors)
vim.opt.termguicolors = true

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- [[ Basic Keymaps ]]
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- use the system clipboard by default for all yank, delete, change, and put operations
vim.opt.clipboard = "unnamedplus" 

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- disable mouse 
vim.opt.mouse = nil

vim.opt.background = "dark"
vim.g.edge_style = 'aura'
vim.g.my_colorscheme = "edge"
vim.cmd("colorscheme " .. vim.g.my_colorscheme)

--- remove highlighted text when enter is pressed
vim.keymap.set({"n", "v"}, "<CR>", "<cmd>nohlsearch<CR><ESC>", { silent = true})
vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<CR>", { silent = true})
vim.keymap.set("n", "<leader>nt", "<cmd>NERDTreeToggle<CR>", { silent = true})
vim.keymap.set("n", "<leader>nf", "<cmd>NERDTreeFind<CR>", { silent = true})
vim.keymap.set("n", "<leader><leader>", "<cmd>buffer #<CR>", { silent = true})
vim.keymap.set("n", "<leader>s", "<cmd>lua require('telescope.builtin').find_files({default_text=vim.fn.expand('<cword>')})<cr>", { silent = true })
vim.keymap.set("n", "<leader>t", "<cmd>bo 10split term://$SHELL<cr>A", { silent = true })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

require("config.cmp")
require("config.lsp")
require("config.luasnip")
require("config.telescope")
require("config.lualine")
require("config.startify")

local getToSymfonyControllerFun = function()
    local fullWord = vim.fn.expand('<cWORD>')
    local t = {}
    for str in string.gmatch(fullWord, "([^"..":".."]+)") do
        table.insert(t, str)
    end
    local functionName = t[#t] .. 'Action'
    table.remove(t, #t)
    local controllerName = table.concat(t) .. 'Controller'
    print("Call symfony for: " .. functionName .. ' ' .. controllerName)
    require('telescope.builtin').find_files({
        default_text = controllerName,
    })
end
local mapKeyForYaml = function()
    vim.keymap.set("n", "gd", getToSymfonyControllerFun)
end
vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = {"yaml"},
        callback = mapKeyForYaml
    })

vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = {"php"},
        command = "setlocal iskeyword-=$",
    })


local save_and_source = function()

    -- save current buffer
    local writeBufCmd = vim.api.nvim_parse_cmd("silent write", {})
    vim.api.nvim_cmd(writeBufCmd, {})

    -- source file
    local sourceCmd = "source %"
    if (vim.bo.filetype == "lua") then
        sourceCmd = "luafile %"
    end
    local parsedSourceCmd = vim.api.nvim_parse_cmd(sourceCmd, {})
    vim.api.nvim_cmd(parsedSourceCmd, {})
    print("Sourced " .. vim.bo.filetype .. " file: " .. vim.fn.expand("%:t"))
end
vim.keymap.set("n", "<leader>x", save_and_source)
