--
-- LUA config file
--
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.list = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
-- gutter limit
vim.opt.colorcolumn="121"

vim.g.mapleader = ","
-- use true colors palette on 24 bits (16 million colors)
vim.opt.termguicolors = true

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

require('plugins.packer')

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

vim.g.my_colorscheme = "OceanicNext"
vim.cmd("colorscheme " .. vim.g.my_colorscheme)
--- remove highlighted text when enter is pressed
vim.keymap.set({"n", "v"}, "<CR>", "<cmd>nohlsearch<CR><ESC>", { silent = true})
vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<CR>", { silent = true})
vim.keymap.set("n", "<leader>nt", "<cmd>NERDTreeToggle<CR>", { silent = true})
vim.keymap.set("n", "<leader>nf", "<cmd>NERDTreeFind<CR>", { silent = true})
vim.keymap.set("n", "<leader><leader>", "<cmd>buffer #<CR>", { silent = true})
vim.keymap.set("n", "<leader>s", "<cmd>lua require('telescope.builtin').find_files({default_text=vim.fn.expand('<cword>')})<cr>", { silent = true })
vim.keymap.set("n", "<leader>t", "<cmd>bo 10split term://$SHELL<cr>A", { silent = true })

require("plugins.cmp")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.feline")

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

require("plugins.startify")

local save_and_exec = function()
    print("save and exec")
end
vim.keymap.set("n", "gy", save_and_exec)
