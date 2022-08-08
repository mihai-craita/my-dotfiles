--
-- LUA config file
--

vim.g.mapleader = ","
-- use true colors palette on 24 bits (16 million colors)
vim.opt.termguicolors = true
vim.g.my_colorscheme = "OceanicNext"
vim.cmd("colorscheme " .. vim.g.my_colorscheme)
--- remove highlighted text when enter is pressed
vim.keymap.set({"n", "v"}, "<CR>", "<cmd>nohlsearch<CR><ESC>", { silent = true})
vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<CR>", { silent = true})
vim.keymap.set("n", "<leader>nt", "<cmd>NERDTreeToggle<CR>", { silent = true})
vim.keymap.set("n", "<leader>nf", "<cmd>NERDTreeFind<CR>", { silent = true})
vim.keymap.set("n", "<leader><leader>", "<cmd>buffer #<CR>", { silent = true})

require("plugins.cmp")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.feline")
